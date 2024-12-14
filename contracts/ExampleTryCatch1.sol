// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract TryCatch {

    function error() external {
        require(false, "Reverteu!");
    }

    function panic() external {
        assert(false);
    }

    function invoca() public returns (string memory) {
        try this.panic() {

        } 
        catch Error(string memory){
            return "Pegou um erro!";
        }
        catch Panic(uint256) {
            return "Pegou um panico!";
        }
    }


}