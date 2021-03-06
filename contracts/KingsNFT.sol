// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Owner.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract KingNFT is ERC721Full, Owner{
    uint [] public KingNFTTokens;

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    mapping (string => bool) _TokenIdExists;
    mapping (address => uint) OwnerTokenCount;
    mapping (uint => address) TokenToOwner;
    mapping (uint => address) TokenApproval;
    
    constructor() ERC721Full("KingNFT", "KNFT"){
    }

    function mint() external isOwner{
    //generate a random number
    uint _tokenId;
    require (!_TokenIdExists[_tokenId]);     
    _mint(msg.sender, _tokenId);
    OwnerTokenCount[msg.sender]++; 
    _TokenIdExists[_tokenId]  = true;
    }

    function balanceOfAddress(address _owner) external view returns (uint256) {
    // 1. Return the number of tokens the `_owner` has here
    return balanceOf(_owner);
    }

  function ownerOfToken(uint256 _tokenId) external view returns (address) {
    // 2. Return the owner of `_tokenId` here
    return ownerOf(_tokenId);
  }


  function transferFromAddress(address _from, address _to, uint256 _tokenId) external payable {
      //require approved owner to do the calling
      require (TokenApproval[_tokenId] == msg.sender);
      transferFrom(_from, _to, _tokenId);        
  }  

  function approveAddress(address _approved, uint256 _tokenId) external payable {
      //require sender actually owns _tokenId
    require (TokenToOwner[_tokenId] == msg.sender);
    TokenApproval[_tokenId] = _approved;
    approve(_approved, _tokenId);           
  }
} 