// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract EtherWallet{
    address payable public Owner;
    address payable public receiver;
    modifier OwnerOnly{
        require(msg.sender==Owner,"Only owner can this function  ");
        _;
    }
    constructor(){
        Owner=payable(msg.sender);
    }
    receive() external payable{}
    function CheckBalance() public view returns(uint){
        return address(this).balance;
    }
     function setreceiver(address payable _receiver) public {
         receiver=_receiver;
    } 
    function SendEther(uint _amount) public OwnerOnly{
      receiver.transfer(_amount);
    }
    function Withdraw(uint _amount) public OwnerOnly{
     payable(msg.sender).transfer(_amount);
    }

}