pragma solidity 0.8.7;

// SPDX-License-Identifier: UNLICENSED;
contract A1 {

    uint private a;
    string private b;
    bool c;

    event Log(string indexed t);
    

    

    function setC() public payable {
        c = !c;
    }

    function setA(uint _x) public payable {
        a = _x;
    }

    function setB(string memory _y) public payable {
        b = _y;
    }


    function getA() public view returns (uint256) {
        return a;
    }

    function getB() public view returns (string memory) {
        return b;
    }

    function getC() public payable returns (bool) {
        emit Log("toggled value of C");
        return c;
    }




}


