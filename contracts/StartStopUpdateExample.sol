// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

contract StartStopUpdateExample {
    address payable public owner;
    bool public paused;

    constructor() {
        owner = payable(msg.sender);
    }

    function sendMoney() payable public {}

    function setPaused(bool _paused) public {
        require(owner == msg.sender, "You are not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(owner == msg.sender, "You are not the owner");
        require(paused == false, "Contract paused");
        _to.transfer(address(this).balance);
    }

    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}