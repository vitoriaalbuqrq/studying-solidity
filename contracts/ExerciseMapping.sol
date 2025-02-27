// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MappingOfMapping {
    mapping (uint => mapping (uint => bool)) uintUintBoolMapping;
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setUintUintBoolMapping(uint _index1, uint _index2, bool _value) public {
        uintUintBoolMapping[_index1][_index2] = _value;
    }

    function getUintUintBoolMapping(uint _index1, uint _index2) public view returns (bool) {
        return uintUintBoolMapping[_index1][_index2];
    }

    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

}