// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Owner.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";

contract KingNFT is ERC721Full, Owner{
    uint [] public KingNFTTokens;
    mapping (string => bool) _randomStringExists;
    mapping (address => uint) OwnerTokenCount;
    mapping (uint => address) TokenToOwner;
    mapping (address => uint) Approval;
    
    constructor() ERC721Full("KingNFT", "KNFT"){
    }

    function mint() external onlyOwner{
    //generate a random number
    string _randomNum;
    require (!_randomStringExists[_randomNum]);
    uint _id = KingNFTTokens.push(randomNum);
    _mint(msg.sender, _id);
    OwnerTokenCount[msg.sender]++; 
    _randomStringExists[randomNum] = true;
    }

    function balanceOf(address _owner) external view returns (uint256) {
    // 1. Return the number of tokens the `_owner` has here
    return OwnerTokenCount[_owner];
    }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    // 2. Return the owner of `_tokenId` here
    return TokenToOwner[_tokenId];
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {

  }

  function approve(address _approved, uint256 _tokenId) external payable {

  }
} 