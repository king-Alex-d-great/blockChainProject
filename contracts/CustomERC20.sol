// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ERC20 {    

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    //transfers _value to an address _to from msg.sender, returns 
    function transfer(address _to, uint256 _value) internal returns (bool success, string memory message) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;

            emit Transfer(msg.sender, _to, _value);
            return (true, "Transfer Successful");        
        }

        return (false, "transfer failed");
    }

    //return the balance of the owner
    function balanceOf(address _owner) internal view returns (uint256 balance) {
        return balances[_owner];
    }

    //return total supply of tokens
    
    function approve(address _spender, uint256 _value) internal returns (bool success) {
        allowance[msg.sender][_spender] = _value; //Am setting the approved value or token to give the spender
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) internal returns (bool success) {

        uint valueToBeTransferred = allowance[_from][_to];

        if (balances[_from] >= _value && valueToBeTransferred  >= _value && _value > 0){
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            valueToBeTransferred -= _value; //sometimes the person might not want to remove all the approved cash once!, we go dey comot am small small

            emit Transfer(msg.sender, _to, _value);
            return (true); 
        }
        return false;
    }

    //Tells us the balance of the value stored for transfer 
    function checkAllowance(address _owner, address _spender) internal view returns (uint256 remaining) {
        return allowance[_owner][_spender];    
    }

    mapping (address => uint256) balances;// mapping address to a balance
    mapping (address => mapping (address => uint256)) allowance; 
    uint256 public totalSupply;
}