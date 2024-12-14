// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MyContract {

    uint public myUint = 123;

    function setMyUint(uint newUint) public {
        myUint = newUint;
    }

}