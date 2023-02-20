pragma solidity ^0.8.0;


// SPDX-License-Identifier: UNLICENSED


contract Tutorial3{

    // uint256 A;
    // uint256 C;
    event emitAddress(address senders);
    address a;

    function getAddress() public returns(address){
        a = msg.sender;
        emit emitAddress(msg.sender);
        return msg.sender;
    }

    function getUint() public returns(uint){
        a = msg.sender;
        return 5;
    }
    


    // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4



}


