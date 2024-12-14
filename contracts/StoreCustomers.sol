// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

contract StoreCustomers {

    struct Customer {
        string name;
        uint8 age;
    }

    uint32 nextId = 0;

    mapping(uint32 => Customer) public customers;

    function getNextId() private returns(uint32) {
        return ++nextId;
    }

    function addCustomer(Customer memory newCustomer) public {
        customers[getNextId()] = newCustomer;
    }
}