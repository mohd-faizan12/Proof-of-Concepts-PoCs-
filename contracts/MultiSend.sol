// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Multisend{
    address payable[] public arr;
    address admin;
    modifier adminOnly{
        require(msg.sender==admin,"You are not allowed");
        _;
    }
    constructor(){
        admin=msg.sender;
    }
    function PushAdd(address _person) public adminOnly {
        arr.push(payable(_person));
    }
    receive() external payable{

    }
    function getBalance() public view adminOnly returns(uint){
        return address(this).balance;
    }
  function SendEther(uint _amount) public payable adminOnly{
      for(uint i=0;i<arr.length;i++){
        
         arr[i].transfer(_amount);
      }
  }
}