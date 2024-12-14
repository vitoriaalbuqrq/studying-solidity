// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Biblioteca{
    uint valor;

    function alteraValor() public {
        valor = valor + 3;
    }
}

contract Upgradable{
    uint public valor;
    address public endereco;

    function alteraEndereco(address _endereco) public {
        endereco = _endereco;
    }

    function alteraValor() public{
        (bool success, ) = endereco.delegatecall(abi.encodeWithSignature("alteraValor()"));
        require(success, "delegatecall para alteraValor falhou");
    }

}