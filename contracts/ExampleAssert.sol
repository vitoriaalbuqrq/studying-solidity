// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Assert {

    uint public saldo = 100;

    function diminui(uint valor) public {
        uint saldoAnterior = saldo;
        saldo = saldo - valor;

        //saldo++; //Assert vai dar falso

        assert(saldoAnterior == saldo + valor);
    }
}