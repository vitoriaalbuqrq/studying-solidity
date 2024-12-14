// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/*contract Chamado {
    
    uint value = 20;

    function getValue() public view returns (uint){
        return value;
    }

    function setValue(uint _value) public {
        value = _value;
    }
}*/

contract Chamador {

    //Quando fizer o deploy desse contrato, tem que passar 1 ether 
    //para que ele tenha dinheiro para enviar para outras contas
    constructor() payable {}

    address endereco = 0x2F3b05feF6265F8574CbC9900A8c581c993fEae6;

    //Implementação tradicional de chamar um contrato utilizando outro
    /*function callSetValue(uint _value) public {
        Chamado chamado = Chamado(endereco);
        chamado.setValue(_value);
    }*/

    //Implementação com Call
    function callSetValue(uint _value) public returns (bool, bytes memory) {
        (bool sucesso, bytes memory retorno) = endereco.call(abi.encodeWithSignature("setValue(uint256)", _value));
        return (sucesso, retorno);
    }

    function callGetValue() public returns (bool, bytes memory) {
        (bool sucesso, bytes memory retorno) = endereco.call(abi.encodeWithSignature("getValue()"));
        return (sucesso, retorno);
    }

    function enviaEther(address _endereco) public returns (bool, bytes memory) {
        (bool sucesso, bytes memory retorno) = _endereco.call{value: 1 ether}("");
        return (sucesso, retorno);
    }

}