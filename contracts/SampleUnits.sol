// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SampleUnits {
    modifier betweenOneAndTwoEth() {
        require(msg.value >= 1 ether && msg.value <= 2 ether);
        _;
    }
    //ether
    //wei
    //gwei

    uint runUnilTimestamp;
    uint startTimestamp;

    constructor(uint startInDays) {
        startTimestamp = block.timestamp + (startInDays * 1 days);
        runUnilTimestamp = startTimestamp + (7 days);
    }
    //seconds
    //minutes
    //hours
    //weeks

}