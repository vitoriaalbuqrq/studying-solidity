// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SampleContract {
    string public myString = "Hello world";

    function updateString(string memory _newString) public payable{
        if(msg.value == 1 wei){
            myString = _newString;
        } else {
            payable(msg.sender).transfer(msg.value);
        }
    }
}