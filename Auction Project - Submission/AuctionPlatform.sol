pragma solidity ^0.8.7;

// SPDX-License-Identifier: MIT



contract AuctionPlatform{

    uint256 auctions = 0;

    address[] public auctionOwners;
    address[] public auctionList;

    mapping(address  => Auction) auctionOwnerList;

    mapping(uint256 => Auction) auctionIdList;


    // struct Bid{





    // }
    struct Auction{

        // address aucOwner;
        uint256 auctionId;
        string description;
        uint32 startTime;
        uint32 endTime;
        uint256 minBidValue;
        uint256 currBidValue;
        // bool isActive;
        

    
    }

    function createAuction(

    
    string memory _description, 
    uint32 _startTime, 
    uint32 _endTime, 
    uint256 _minBidValue
    
    ) public {

        auctions += 1;

        auctionOwnerList[msg.sender] = Auction(auctions,_description,_startTime,_endTime,_minBidValue,_minBidValue)  ;

        auctionIdList[auctions] = auctionOwnerList[msg.sender];

        auctionOwners.push(msg.sender);
        
    }









    // uint public blockA = block.number;

    // function timePass(uint a) public payable{
        
    //     blockA = blockA - a;


    // }

    // function timeTest(uint256 b) public pure returns(uint){
    //     uint t1 = 1 days;
    //     return t1 - b;
        
    // }
    




}

