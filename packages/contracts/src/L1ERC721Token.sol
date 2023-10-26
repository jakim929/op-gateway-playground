// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.21;

// import { ERC721 } from "solmate/tokens/ERC721.sol";
// import { L1CrossDomainMessenger } from "@eth-optimism/contracts-bedrock/src/L1/L1CrossDomainMessenger.sol";

// contract L1ERC721Token is ERC721 {
//   L1CrossDomainMessenger public l1CrossDomainMessenger;

//   constructor(string memory _name, string memory _symbol, L1CrossDomainMessenger _l1CrossDomainMessenger) ERC721(_name, _symbol) {
//     l1CrossDomainMessenger = l1CrossDomainMessenger;
//   }

//   function mint(address _to) public {
//     // Add allowlist or access control to minting 
//     _mint();
//   }

//   function tokenURI(uint256 id) public view virtual returns (string memory) {
//     return 'Hello';
//   }
// }