pragma solidity ^0.4.26;
// SPDX-License-Identifier: MIT

// import "https://github.com/bokkypoobah/BokkyPooBahsDateTimeLibrary/blob/1ea8ef42b3d8db17b910b46e4f8c124b59d77c03/contracts/BokkyPooBahsDateTimeLibrary.sol";


contract Auction {



    // struct DateTime{
    //     uint year;
    //     uint month;
    //     uint day;
    //     uint hour;
    //     uint min;
    //     uint sec;
    // }

    // uint aucId;

    string description;
    uint startTime;
    uint endTime;
    uint minBidVal;
    
    bool bidsMade;

    mapping(address => uint) bids;
    address[] biddersList;

    function getBidsMade() external view returns(bool){
        return bidsMade;
    }
    function getEndTime() external view returns(uint256){
        return endTime;
    }

    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    function getMinBidVal() external isActive view returns(uint){
        return minBidVal;
    }

    function getListOfBids() external isActive view returns(uint[]){
        
        uint[] memory list = new uint[](biddersList.length);

        for(uint i;i<biddersList.length;i++){
            
            list[i] = bids[biddersList[i]];

        }
        return list;
    }


    constructor(string memory _description, uint _startTime, uint _endTime, uint _minBidVal) public {


        // aucId = _aucId;
        description = _description;
        startTime = _startTime;
        endTime = _endTime;
        minBidVal = _minBidVal;


    }

    function createBid(uint _bidVal) external validBidVal(_bidVal) isActive isBidPresent {

        bidsMade = true;
        bids[tx.origin] = _bidVal;
        biddersList.push(tx.origin);

    }

    function endAuctionWithSelectedBid(uint bid) external isActive returns(address){
        endTime = block.timestamp;
        address winner;
        for(uint i =0;i<biddersList.length;i++){
            if(bids[biddersList[i]]==bid){
                winner = biddersList[i];
                break;
            }
        }
        return winner;
    }

    function getMaximumBid() external isActive view returns(uint){

        uint maxBid = 0;
        for(uint i;i<biddersList.length;i++){
            maxBid = max(bids[biddersList[i]],maxBid);
        }
        return maxBid;


    }

    modifier isActive(){
        require(block.timestamp < endTime,"Auction is Inactive ");
        _;
    }

    modifier isBidPresent(){
        require(bids[tx.origin]==0,"You have already created a bid");
        _;
    }

    // modifier hasBids(){
    //     require()
    // }

    modifier validBidVal(uint _bidVal){
        require(_bidVal > minBidVal,"Please enter a bid greater than minimum required bid of given auction");
        _;
    }




}