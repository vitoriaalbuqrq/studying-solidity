// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ExampleUint {
    //0 - (2^256)-1
    uint public myUint; //OBS: se não precisar iniciar com valor padrao, deixar em branco, pois consome gas extra
    
    uint8 public myUint8 = 2**4; //define o tamanho

    //(2^128) to +2^128-1
    int public myInt = -10;

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function decrementUint() public {
        myUint--;
    }

    function increementUint8() public {
        myUint8++;
    }

    function incrementInt() public {
        myInt++;
    }
}