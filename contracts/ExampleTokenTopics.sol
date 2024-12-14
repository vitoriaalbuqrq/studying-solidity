// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Topicos {

    event Register(address indexed _to, address indexed _from, uint val1, uint val2);

    function emitRegister(address _to, address _from, uint val1, uint val2) public {
        emit Register(_to, _from, val1, val2);
    }
}