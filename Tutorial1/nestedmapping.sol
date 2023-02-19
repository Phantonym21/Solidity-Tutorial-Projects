pragma solidity ^0.8.7;



// SPDX-License-Identifier: MIT


contract  Mapping{

    // mapping(uint256=>mapping(uint256=>string)) public buuger;

    uint[] public simpleArray;




    // function bau(uint a,uint b) public {
    //     buuger[a][b] = "BUUGER";

        
    // }

    function arrayReturn() public view returns(uint[] memory){
        return simpleArray;
    }

    function array() public payable{

        simpleArray[0] = 123;
        simpleArray[1] = 1312;
        simpleArray[2] = 798;

    }
    




}