// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Owner.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";

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

    function mint() external onlyOwner{
    //generate a random number
    uint _tokenId;
    require (!_TokenIdExists[_tokenId]);
    uint _id = KingNFTTokens.push(tokenId);
    _mint(msg.sender, _id);
    OwnerTokenCount[msg.sender]++; 
    _randomStringExists[tokenId] = true;
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
      //require approved owner to do the calling
      require (TokenApproval[_tokenId] == msg.sender);
        _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable {
      //require sender actually owns _tokenId
    require (TokenToOwner[_tokenId] == msg.sender);
      //Add approve to the _approved address
    TokenApproval[_tokenId] = approved; 
    emit Approval(msg.sender, _approved, _tokenId);     
  }
} 