// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Modificador {

    address public dono = msg.sender;
    uint restrita;

    // Este modificador será usado para restringir o acesso a funções do contrato.
    modifier onlyOwner() {
        // Verifica se o endereço que está chamando a função (msg.sender) é igual ao endereço do dono.
        require(msg.sender == dono, "Somente o dono pode executar esta funcao");
        // Se a verificação passar, continua a execução da função onde o modificador foi aplicado.
        _;
    }

    // Esta função permite definir o valor da variável "restrita".
    // A palavra-chave "onlyOwner" aplica o modificador, restringindo o acesso apenas ao dono.
    function setRestrita(uint _valor) public onlyOwner {
        // Define o valor de "restrita" como o valor fornecido no argumento "_valor".
        restrita = _valor;
    }
}