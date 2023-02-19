pragma solidity ^0.8.7;

// SPDX-License-Identifier: MIT



contract AuctionPlatform{

    uint256 auctionsCount = 0;

    address[] public auctionOwners;
    // address[] public auctionList;

    Auction[] public auctionList;

    mapping(address => Auction) auctionOwnerList;
    
    mapping(uint256 => Bid[])  bidList;  // Auction Owner

    mapping(address => Auction[]) bidderAuctionList;  // Bidder

    // mapping(uint256 => Auction) auctionIdList;






    struct Bid{

        address bidOwner;
        uint256 auctionId;
        uint256 amount;

    }  

    struct Auction{

        // address aucOwner;
        uint256 auctionId;
        string description;
        uint32 startTime;
        uint32 endTime;
        uint256 minBidValue;
        // uint256 currMaxBidValue;
        // uint256[] bidList;
        // mapping(uint256 => address) bidList;
        // bool isActive;


    
    }


    function createAuction(

    
    string memory _description, 
    uint32 _startTime, 
    uint32 _endTime, 
    uint256 _minBidValue
    
    ) public payable {

        auctionsCount += 1;
        
        // uint256[] memory _bidList;

        // mapping(uint256 => address) memory _bidList;

        auctionOwnerList[msg.sender] = Auction(auctionsCount, _description ,_startTime,_endTime,_minBidValue);
        auctionOwners.push(msg.sender);
        auctionList[auctionsCount] = auctionOwnerList[msg.sender];
        

        // auctionList[auctionsCount] = auctionOwnerList[msg.sender];

       
        
    }

    function createBid(
        
        uint256 _bidAmount,
        uint256 _aucId


) public payable isActive  (_aucId) {

        require(_bidAmount > auctionList[_aucId].minBidValue, "Bid Amount should be greater then minimum Bid Value");

        bidList[_aucId].push(Bid(msg.sender,_bidAmount,_aucId));

        bidderAuctionList[msg.sender].push(auctionList[_aucId]);



        // Auction memory currBidAuction = auctionList[_aucId];

        // if(currBidAuction.currMaxBidValue < _bidAmount){
        //     auctionList[_aucId].currMaxBidValue  = _bidAmount;
        // }
    }

    function checkBids()public view returns(Bid[] memory){
        
        return bidList[auctionOwnerList[msg.sender].auctionId];

    }   

    function checkBiddedAuctions() public isAuctionCreater view returns(Auction[] memory){

        return bidderAuctionList[msg.sender];

    }










    // MODIFIERS



    modifier isAuctionCreater(){
        require(auctionOwnerList[msg.sender].auctionId > 0 && auctionOwnerList[msg.sender].endTime<block.timestamp, "You don't have an active auction");
        _;
    }

    // modifier isAuctionPresent(uint256 _)
    modifier isActive(uint256 _aucId){
        require(
            
            _aucId <= auctionsCount && auctionList[_aucId].startTime < block.timestamp && auctionList[_aucId].endTime > block.timestamp ,
            "Auction Is Not Active or Not Present"

        );
        _;
    }

    modifier isGreaterThenMinBid(uint256 _aucId,uint256 _amount){
        require(
            _amount>auctionList[_aucId].minBidValue,
            "Bid Amount should be greater then minimum Bid Value"
        );
        _;
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

