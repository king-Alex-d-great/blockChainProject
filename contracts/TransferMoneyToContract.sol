// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Owner.sol";

contract TransferMoneyToContract is Owner{

    address payable myAddress = payable(address (this));
    
    uint gasFee = 0.0002 ether;

    //When money is sent from the DApp, tell me via an event
    event MoneySentToAlex(address sender, uint timeStamp);

    //Function to remove sapa!
    function receiveMoney() external payable returns (uint) {

        require(msg.value == gasFee);        
        myAddress.transfer(msg.value);

        emit MoneySentToAlex (msg.sender, block.timestamp);

        return msg.value;
    }

    //So as the owner of this contract
    //i want to be able to externally change the gas fee of this contrcat when i want
    //that why i inherited Owner
    //but because changing a global  variable will always need gas fee, am contemplating making gas fee static or finding a better way to make it better! 
    function changeFee (uint32 newFee) external isOwner {

    }
}