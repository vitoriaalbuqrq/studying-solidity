// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SampleFallback {

    uint public lastValueSend;
    string public lastFunctionCalled;

    receive() external payable {
        lastValueSend = msg.value;
        lastFunctionCalled = "receive";
    }
    fallback() external payable {
        lastValueSend = msg.value;
        lastFunctionCalled = "fallback";
    }
}