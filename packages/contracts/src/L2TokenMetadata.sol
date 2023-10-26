// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import { ERC721 } from "solmate/tokens/ERC721.sol";
import { IL2CrossDomainMessenger } from "./interfaces/IL2CrossDomainMessenger.sol";

contract L2TokenMetadata {
  IL2CrossDomainMessenger public l2CrossDomainMessenger;
  address public l1TokenContract;

  mapping(uint256 => address) public ownerByTokenId;
  mapping(uint256 => bool) public isLockedByTokenId;
  mapping(uint256 => bytes32) public metadataByTokenId;


  constructor(address _l2CrossDomainMessenger, address _l1TokenContract) {
    l2CrossDomainMessenger = IL2CrossDomainMessenger(_l2CrossDomainMessenger);
    l1TokenContract = _l1TokenContract;
  }

  function updateOwner(uint256 _tokenId, address _newOwner) public onlyL1TokenContract {
    require(isLockedByTokenId[_tokenId] == true, 'Token must be locked before owner can be updated');
    ownerByTokenId[_tokenId] = _newOwner;

    // what if updateOwner fails
  }

  function lock(uint256 _tokenId) public onlyL1TokenContract {
    isLockedByTokenId[_tokenId] = true;
  }

  function unlock(uint256 _tokenId) public onlyL1TokenContract {
    isLockedByTokenId[_tokenId] = false;
  }

  function updateMetadata(uint256 _tokenId, bytes32 _metadata) public {
    require(isLockedByTokenId[_tokenId] == false, 'Token must be unlocked to update metadata');
    require(_msgSender() == ownerByTokenId[_tokenId], 'Only owner can update metadata');

    metadataByTokenId[_tokenId] = _metadata;
  }

  modifier onlyL1TokenContract() virtual {
    require(msg.sender == address(l2CrossDomainMessenger));
    require(l2CrossDomainMessenger.xDomainMessageSender() == l1TokenContract);

    _;
  }

  function _msgSender() internal view returns (address) {
    if (msg.sender == address(l2CrossDomainMessenger)) {
      return l2CrossDomainMessenger.xDomainMessageSender();
    }
    return msg.sender;
  }
}