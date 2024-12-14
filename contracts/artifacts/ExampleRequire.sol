// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Dono {
    address public endereco;

    function alteraEndereco() public {
        endereco = msg.sender;
    }

    function privada() public view {
        require(msg.sender==0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        
    }
}