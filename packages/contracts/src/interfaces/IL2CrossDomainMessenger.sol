// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

interface IL2CrossDomainMessenger {
  function xDomainMessageSender() external view returns (address);
}