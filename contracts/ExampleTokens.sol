// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MyToken {
    string _name = "My Token";
    string _symbol = "MTK";
    uint8 _decimals = 8;
    uint _totalSupply;
    mapping(address => uint) _balance;

    constructor() {
        _totalSupply = 100_000 * 10 ** _decimals;
        _balance[msg.sender] = _totalSupply;
    }

    function name() public view returns(string memory){
        return _name;
    }

    function symbol() public view returns(string memory) {
        return _symbol;
    }

    function decimals() public view returns(uint8) {
        return _decimals;
    }

    function totalSupply() public view returns(uint) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint) {
        return _balance[_owner];
    }
}