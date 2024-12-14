// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ExampleStrings {
    
    string public myString = "Hello world";
    bytes public myBytes = "Hello word";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }

    function compareTwostring(string memory _myString) public view returns(bool) {
        return keccak256(abi.encode(myString)) == keccak256(abi.encode(_myString));
    }
    function getBytesLength() public view returns(uint) {
        return myBytes.length;
    }
}