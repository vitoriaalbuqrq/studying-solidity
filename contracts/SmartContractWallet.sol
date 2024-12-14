// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SmartContractWallet {
    address payable owner;

    // Mapping para controlar permissões de gastos
    mapping(address => uint) public allowance; // Armazena o valor que cada endereço pode gastar
    mapping(address => bool) public isAllowedToSend; // Indica se um endereço tem permissão para enviar fundos

    // Configuração de guardiões para recuperação do contrato
    mapping(address => bool) public guardian; // Indica se um endereço é um guardião
    address payable nextOwner; // Armazena o endereço proposto como próximo proprietário
    uint guardiansResetCount; // Contador de confirmações de guardiões para mudar o proprietário
    uint public constant confirmationsFromGuardiansForReset = 3; // Confirmações necessárias para mudança de proprietário

    // Construtor: Define o proprietário inicial do contrato
    constructor() {
        owner = payable(msg.sender);
    }

    // Permite que um guardião proponha um novo proprietário para o contrato
    function proposeNewOwner(address payable newOwner) public {
        // Apenas um guardião pode chamar essa função
        require(guardian[msg.sender], "You are no guardian, aborting");

        // Reseta o progresso de confirmação caso o novo proprietário seja diferente do anterior
        if(nextOwner != newOwner) {
            nextOwner = newOwner; // Atualiza o próximo proprietário
            guardiansResetCount = 0; // Reseta o contador de confirmações
        }

        guardiansResetCount++; // Incrementa o contador de confirmações

        // Se o número de confirmações atingir o necessário, altera o proprietário
        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            owner = nextOwner; // Transfere a propriedade
            nextOwner = payable(address(0)); // Reseta o próximo proprietário
        }
    }

    // Permite que o proprietário configure uma permissão de gasto para um endereço
    function setAllowance(address _from, uint _amount) public {
        // Apenas o proprietário pode configurar permissões
        require(msg.sender == owner, "You are not the owner, aborting!");
        allowance[_from] = _amount; // Define o valor que o endereço pode gastar
        isAllowedToSend[_from] = true; // Concede permissão ao endereço
    }

    // Permite que o proprietário revogue a permissão de gasto de um endereço
    function denySending(address _from) public {
        // Apenas o proprietário pode revogar permissões
        require(msg.sender == owner, "You are not the owner, aborting!");
        isAllowedToSend[_from] = false; // Revoga a permissão
    }

    // Função para transferir fundos do contrato
    function transfer(address payable _to, uint _amount, bytes memory payload) public returns (bytes memory) {
        // Garante que o contrato possui saldo suficiente para a transferência
        require(_amount <= address(this).balance, "Can't send more than the contract owns, aborting.");

        // Caso o remetente não seja o proprietário (o remetente não é o proprietário, então ele precisa de permissões especiais para enviar fundos)
        if(msg.sender != owner) {
            // Garante que o remetente tem permissão para enviar fundos
            require(isAllowedToSend[msg.sender], "You are not allowed to send any transactions, aborting");

            // Garante que o remetente não está gastando mais do que permitido
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, aborting");

            // Deduz o valor enviado do limite do remetente
            allowance[msg.sender] -= _amount;
        }

        // Executa a transferência usando a função `call`
        (bool success, bytes memory returnData) = _to.call{value: _amount}(payload);

        // Garante que a transferência foi bem-sucedida
        require(success, "Transaction failed, aborting");

        // Retorna os dados da transação
        return returnData;
    }

    // Função que permite ao contrato receber Ether diretamente
    receive() external payable {}
}