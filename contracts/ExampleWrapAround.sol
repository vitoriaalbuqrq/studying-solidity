// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ExampleWrapAround {

    uint8 public myUint8 = 250; 

    function decrement() public {
        myUint8--;
    }

    function increment() public {
        myUint8++;
    }
}