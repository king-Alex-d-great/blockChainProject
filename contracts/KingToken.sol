// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./CustomERC20.sol";

contract KingToken is ERC20{

    string public name;                   
    uint8 public decimals;                
    string public symbol;                 
    string public version = 'H1.0';

    constructor (
        ) {
        balances[msg.sender] = 10000;               
        totalSupply = 10000;                        
        name = "KingToken";                                  
        decimals = 8;                           
        symbol = "KNGT";                               
    }

    /* Approves the receiving contract */
        function approveCall(address  _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);         
        return true;
    }    
}