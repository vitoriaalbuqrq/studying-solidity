// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Erros {

    uint public limite = 10;
    error outOfRange(uint limite, uint valorRecebido);

    function recebe(uint _valor) public {
        if (_valor > limite) revert outOfRange(limite, _valor);
    }

    function limitada(uint _valor) public pure{
        //require(_valor <= 10, "O valor não está dentro do limite");
        if(_valor > 10) revert(unicode"O valor não está dentro do limite");
    }
}