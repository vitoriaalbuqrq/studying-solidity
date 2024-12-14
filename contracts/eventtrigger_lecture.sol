// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Contrato base para controle de acesso
// Pode ser gerado com o openZeppelin
contract Ownable {
    address public _owner;

    constructor() {
        _owner = msg.sender;
    }

    // Modificador que restringe funções ao proprietário
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _; 
    }

    function isOwner() public view returns (bool) {
        return (msg.sender == _owner);
    }
}

// Representa um item na cadeia de suprimentos
contract Item {
    uint public priceInWei; // Preço do item em Wei
    uint public paidWei;    // Valor pago até agora
    uint public index;      

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) {
        priceInWei = _priceInWei;
        index = _index;           
        parentContract = _parentContract; 
    }

    // Função especial para receber pagamentos
    receive() external payable {
        require(msg.value == priceInWei, "We don't support partial payments"); // Verifica se o pagamento é exato
        require(paidWei == 0, "Item is already paid!"); // Certifica que o item ainda não foi pago

        paidWei += msg.value; // Atualiza o valor pago

        // Notifica o ItemManager que o pagamento foi realizado
        (bool success, ) = address(parentContract).call{
            value: msg.value
        }(abi.encodeWithSignature("triggerPayment(uint256)", index));

        require(success, "Delivery did not work"); // Verifica se a chamada foi bem-sucedida
    }

    // Fallback vazio para capturar chamadas inválidas e garantir que elas não quebrem o contrato
    fallback() external {}
}

// Contrato principal para gerenciar os itens
contract ItemManager is Ownable {
    // Enum para representar os estados de um item
    enum SupplyChainState { Created, Paid, Delivered }

    // Estrutura que armazena informações de um item
    struct S_Item {
        Item _item;                      // Contrato do item
        string _identifier;              // Identificador único
        uint _itemPrice;                 // Preço do item
        ItemManager.SupplyChainState _state; // Estado atual
    }

    mapping(uint => S_Item) public items; // Mapeia índices para itens
    uint itemIndex; // Contador para itens criados

    // Evento para rastrear mudanças na cadeia de suprimentos
    event SupplyChainStep(uint _itemIndex, uint _step, address _address);

    // Cria um novo item
    function createItem(string memory _identifier, uint _itemPrice) public onlyOwner {

        Item item = new Item(this, _itemPrice, itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = SupplyChainState.Created;

        // Emite um evento indicando que o item foi criado
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state), address(item));
        itemIndex++; 
    }

    // Atualiza o estado do item para "Paid" após pagamento
    function triggerPayment(uint _itemIndex) public payable {
        Item item = items[_itemIndex]._item; // Referência ao contrato do item
        // Verifica se o contrato do item está chamando
        require(address(item) == msg.sender, "Only items are allowed to update themselves");
        // Verifica se o valor enviado corresponde ao preço
        require(item.priceInWei() == msg.value, "Not fully paid yet");
        // Verifica se o item está no estado "Created"
        require(items[_itemIndex]._state == SupplyChainState.Created, "Item is further in the supply chain");
        // Atualiza o estado para "Paid"
        items[_itemIndex]._state = SupplyChainState.Paid;
        // Emite um evento indicando que o pagamento foi realizado
        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(item));
    }

    // Atualiza o estado do item para "Delivered"
    function triggerDelivery(uint _itemIndex) public onlyOwner {
        // Verifica se o item está no estado "Paid"
        require(items[_itemIndex]._state == SupplyChainState.Paid, "Item is further in the chain");
        // Atualiza o estado para "Delivered"
        items[_itemIndex]._state = SupplyChainState.Delivered;
        // Emite um evento indicando que a entrega foi concluída
        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state), address(items[_itemIndex]._item));
    }
}
