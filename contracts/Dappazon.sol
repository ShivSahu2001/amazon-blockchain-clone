// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    //code
    // string public name;

    // blockchain address of owner
    address public owner;

// we will take function parameters and add in the structure
    struct Item{
        uint256 id;
        string name;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
        uint256 stock;

    }

    // mapping to store in key-value pair
    //  unique key is asigned to every item
    mapping(uint256 => Item) public items;

    constructor() {
        // name = "Dappazon";
        owner = msg.sender;
    }

    // List products
    // public -> means somebody outside the smart cantracts can call these function
    function list(uint256 _id,
    string memory _name,
    string memory _category,
    string memory _image,
    uint256 _cost,
    uint256 _rating,
    uint256 _stock
    ) public {

        // Create Item struct
        // here Item is a data type
        // This is used to create in memory 
        Item memory item = Item(_id,
         _name,
         _category,
         _image,
         _cost,
         _rating,
         _stock);

        //  Save Item struct to blockchain
        items[_id] = item;

    }

    // Buy products

    // Withdraw funds
}
