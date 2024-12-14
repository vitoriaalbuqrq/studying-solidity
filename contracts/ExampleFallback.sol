// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ExampleFallback {

    uint public dinheiro;

    fallback() external payable { }

    receive() external payable {
        dinheiro = dinheiro + msg.value;
    }

    function foo() public pure returns(uint) {
        return 12;
    }
}