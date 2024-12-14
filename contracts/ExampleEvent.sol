// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Eventos {

    uint public valor;
    event AlteraValor(uint);

    function alteraValor(uint _valor) public {
        valor = _valor;
        emit AlteraValor(_valor);
    }
}