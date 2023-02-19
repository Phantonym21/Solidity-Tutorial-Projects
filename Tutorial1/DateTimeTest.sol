pragma solidity ^0.4.26;
pragma experimental ABIEncoderV2;

//SPDX-License-Identifier: MIT
import "https://github.com/bokkypoobah/BokkyPooBahsDateTimeLibrary/blob/1ea8ef42b3d8db17b910b46e4f8c124b59d77c03/contracts/BokkyPooBahsDateTimeLibrary.sol";
// import "https://etherscan.io/address/0x23d23d8f243e57d0b924bff3a3191078af325101#readContract#F6";



contract A {

    // using BokkyPooBahsDateTimeLibrary for uint;


    // function test1(uint256 year,uint256 month,uint256 day) public pure returns(uint256){

    //    return BokkyPooBahsDateTimeLibrary._daysFromDate(year,month,day);

    // }

    // uint public b = 0;
    // function test2() public {

    //     uint a = now;
    //     b= a.getDaysInMonth();
    // }
    
    // bool public c = true;
    // function test2(uint year, uint month, uint day, uint hour, uint minute, uint sec) public {

    //     c = BokkyPooBahsDateTimeLibrary.isValidDateTime(year,month,day,hour,minute,sec);

    // }

    struct DateTime{
        uint year;
        uint month;
        uint day;
        uint hour;
        uint min;
        uint sec;
    }

    DateTime public a1;


    function test3(DateTime a) public{
        a1 = a;
    }
// // 
//     uint public a;
//     function test4() public{
//         a = Date.now();
//     }
    // timestampFromDateTime
    // isValidDateTime



}






