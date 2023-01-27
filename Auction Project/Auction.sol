pragma solidity 0.8.7;
// SPDX-License-Identifier: UNLICENSED;



//LIBRARY


library Structure{
    struct Winner{
        address id;
        uint256 amount;
    }
}

library SafeMath{

    
    function add(uint256 a, uint256 b) internal pure returns(uint256){
        uint256 c = a+ b;
        assert(c>=a);
        return c;
    }

}

contract Auction {

    bool allowBid;
    address owner;
    string nameOfItem;
    uint256 startingBid;

    using Structure for Structure.Winner;

    Structure.Winner user;

    // Bid list
    mapping(address=>uint256) public bidList;

    using SafeMath for uint256;

    constructor(string memory _nameOfItem, uint256 _startingBid) public {
        owner = msg.sender;
        nameOfItem = _nameOfItem;
        startingBid = _startingBid;
        allowBid = true;
        user.id = owner;
        user.amount = _startingBid;
        }



    // EVENTS

    
    
    
    


    // MODIFIERS

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier checkBid{
        require(allowBid);
        _;
    }

    modifier checkBidAmount(uint256 _amount){
        require(_amount > startingBid);
        _;
    }

    //FUNCTIONS
    //Toggle Bid on or off
    function controlBid() public onlyOwner payable{
        if(allowBid){
            allowBid = false;
            //emit Bids are off
        }else{
            allowBid = true;
            //emit Bids are on
        }
    }


    //Create Bid
    function createBid(uint256 _amount) public checkBid checkBidAmount(_amount) payable {
        
        if(bidList[msg.sender]!=0){
        bidList[msg.sender] = _amount;
        if(user.amount< _amount){
            user.id = msg.sender;
            user.amount = _amount;
        }

        }else{
            //emit bid is already created by you use update bid to increase amount;
        }
        //emit Bid created by..
    }

    function updateBid(uint256 _amount) public checkBid payable {
        if(bidList[msg.sender]==0){
            //emit you need to create a bid first

        }else{
            bidList[msg.sender].add(_amount);
            if(user.amount<bidList[msg.sender]){
                user.id = msg.sender;
                user.amount = bidList[msg.sender];

            }

            //emit bid updated;
        }
    }

    function closeBid() public onlyOwner {

        address payable o = payable(owner);
        //emit winner is user;
        selfdestruct(o);




    }




}