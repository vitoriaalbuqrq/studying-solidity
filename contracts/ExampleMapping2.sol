// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ExampleMappingWithdrawals {
    
    // Mapeamento para rastrear o saldo de cada endereço.
    mapping(address => uint) public balanceReceived;

    // Função para enviar dinheiro (ETH) para o contrato
    function sendMoney() public payable {
        // O valor enviado na transação (`msg.value`) é adicionado ao saldo do remetente (`msg.sender`)
        balanceReceived[msg.sender] += msg.value;
    }

    // Função para obter o saldo total do contrato
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // Função para o remetente sacar todo o dinheiro que ele depositou
    function withdrawAllMoney(address payable _to) public {
        // Obtém o saldo do remetente no mapeamento
        uint balanceToSendOut = balanceReceived[msg.sender];
        // Reseta o saldo do remetente para 0 antes de transferir o valor. Isso protege contra ataques de reentrância
        balanceReceived[msg.sender] = 0;
        // Transfere o valor para o endereço fornecido. `_to` deve ser um endereço válido e "pagável"
        _to.transfer(balanceToSendOut);
    }
}