// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ExampleExceptionrequire {

    mapping (address => uint) public balanceReceived;

    function receiveMoney() public payable {
        assert(msg.value == uint8(msg.value));
        balanceReceived[msg.sender] += uint8(msg.value);
        assert(balanceReceived[msg.sender] >= uint8(msg.value));
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        //if(_amount <= balanceReceived[msg.sender]){
        require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting!");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
            balanceReceived[msg.sender] -= _amount;
            _to.transfer(_amount);
    }
}