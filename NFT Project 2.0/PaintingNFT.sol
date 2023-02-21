// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;




import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";




contract PaintingNFT is ERC721,ERC721URIStorage{

        ////////////////////////////// Overrides required //////////////////////////////////

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

         ////////////////////////////// Overrides required //////////////////////////////////

    address owner;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    using SafeMath for uint;
    constructor() ERC721("PaintingsNFT","PNFT"){
        owner = msg.sender;
    }

    // mint price = 0.0000005 eth;
    uint constant public mintPrice = 500000000000;
    enum ListingStatus{
        active,
        sold,
        removed
    }
    struct Listing {
        address owner;
        string title;
        string description;
        uint price;
        string uri;
        ListingStatus status;
    }

    mapping(uint => Listing) listings;
    // mapping(address => Listing[]) ownListings;

    uint public actualCount;
    uint numberOfListings;   //

    // function withdrawAmount() public payable onlyOwner{
    //     payable(msg.sender).transfer(address(this).balance);
    // }

    // function viewFunds() public view onlyOwner returns(uint){
    //     return address(this).balance;
    // }

    function createListing(string memory _title, string memory _description, string memory _uri, uint _price) public minPrice(_price) returns(uint){

        Listing storage listing = listings[numberOfListings];

        listing.owner = msg.sender;
        listing.title = _title;
        listing.description = _description;
        listing.price = _price;
        listing.uri = _uri;
        listing.status = ListingStatus.active;

        actualCount++;
        numberOfListings++;

        return numberOfListings-1;
    
    }


    function removeListing(uint _listingId) public{
        Listing storage listing = listings[_listingId];
        require(listing.owner == msg.sender,"You are not the owner of the listing, only the owner can remove the listing");

        listing.status = ListingStatus.removed;
        actualCount--;

    }


    function viewListings() public view returns(Listing[] memory){
        Listing[] memory tempList = new Listing[](actualCount);
        uint j = 0;
        for(uint i;i<numberOfListings;i++){
            if(listings[i].status==ListingStatus.sold || listings[i].status == ListingStatus.removed){
                continue;
            }else{
                tempList[j] = listings[i];
                j++;
            }

        }
        return tempList;

    }

    function buyListing(uint _listingId) public payable validListingId(_listingId){


        // require(_listingId<numberOfListings,"Enter a valid Id of the Listing you want");

        Listing storage listing = listings[_listingId];
        require(listing.status!=ListingStatus.sold && listing.status != ListingStatus.removed,"Listing is not active");
        require(listing.price+mintPrice <= msg.value,"not enough funds sent");

         uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);

        _setTokenURI(tokenId,listing.uri);

        payable(listing.owner).transfer(msg.value - mintPrice);

        listing.status = ListingStatus.sold;
        actualCount--;

    }


    //////////// MODIFIERS ////////////////


    modifier onlyOwner(){
        require(msg.sender==owner,"only Owner can withdraw funds");
        _;
    }
    
    modifier validListingId(uint _listingId) {
        require(_listingId<numberOfListings,"Enter a valid Id of the Listing you want");
        _;
    }
    modifier minPrice(uint _price){
        require(_price>mintPrice,"minimum price should be greater than 0.0000005 eth");
        _;
    }

}