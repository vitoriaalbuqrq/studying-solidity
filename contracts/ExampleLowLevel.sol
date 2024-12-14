// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;


// Contrato responsável por enviar Ether.
contract Sender {
    // Permite que o contrato receba Ether sem realizar ações específicas.
    receive() external payable {}

    // Envia 10 wei para o endereço `_to` usando `transfer`.
    // O método `transfer` reverte a transação automaticamente em caso de falha.
    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    // Envia 10 wei para o endereço `_to` usando `send`.
    // O método `send` retorna `false` em caso de falha, mas não reverte a transação.
    function withdrawSend(address payable _to) public {
        bool sentSuccessful = _to.send(10);
        // Nota: `sentSuccessful` armazena se o envio foi bem-sucedido.
        // No entanto, não há verificação ou tratamento adicional aqui.
    }
}

// Contrato que pode receber Ether, mas não realiza nenhuma ação quando isso ocorre.
contract ReceiverNoAction {

    // Retorna o saldo de Ether armazenado no contrato.
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    // Permite que o contrato receba Ether diretamente.
    receive() external payable {}
}

// Contrato que pode receber Ether e realiza uma ação ao recebê-lo.
contract ReceiverAction {
    uint public balanceReceived; // Registra o total de Ether recebido pelo contrato.

    // Retorna o saldo de Ether armazenado no contrato.
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    // Recebe Ether e atualiza a variável `balanceReceived` com o valor recebido.
    receive() external payable {
        balanceReceived += msg.value;
    }
}

