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

    struct Order{
        uint256 time;
        // nested structure of item
        Item item;
    }

    // mapping to store in key-value pair
    //  unique key is asigned to every item
    mapping(uint256 => Item) public items;
    mapping(address => uint256) public orderCount;
    // nested mapping
    mapping(address => mapping(uint256 => Order)) public orders;

    event Buy(address buyer, uint256 orderId, uint256 itemId);
    event List(string name, uint256 cost, uint256 quantity);

// it means only owner can call these modifier.
    modifier onlyOwner() {
        // true -> means start executing the function
        // false -> means stop executing the function
        require(msg.sender == owner);
        _;
    }

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
    ) public onlyOwner {
        

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

        // EMIT an Event
        // so that you can get push notification or alert an Email for website
        emit List(_name, _cost, _stock);

    }

    // Buy products
    function buy(uint256 _id) public payable {
        // Receive Crypto

            // Fetch Item
            Item memory item = items[_id];

            // Require enough ether to buy item
            require(msg.value >= item.cost);

            // Require item is in stock
            require(item.stock > 0);

        // Create an Order
            Order memory order = Order(block.timestamp, item);

            // Save order to chain
            // Add order for user 
            orderCount[msg.sender]++; // -- order ID
            orders[msg.sender][orderCount[msg.sender]] = order;

        // Substract Stock
        items[_id].stock = item.stock - 1;

        // Emit Event
        emit Buy(msg.sender, orderCount[msg.sender], item.id);
    }

    // Withdraw funds
    function withdraw() public onlyOwner {
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success);
    }
}
