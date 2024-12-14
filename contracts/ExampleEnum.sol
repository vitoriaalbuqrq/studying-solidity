// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Enums {

    enum Status {
        aberto, fechado, progresso
    }

    Status status;

    constructor() {
        status = Status.aberto;
    }

    function continua() public view{

        if (status == Status.aberto) {
            //
        }
    }
}