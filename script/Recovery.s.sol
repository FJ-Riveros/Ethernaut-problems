// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Recovery.sol";

contract RecoveryScript is Script {
  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    address deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
    vm.startBroadcast(deployerPrivateKey);

    SimpleToken instance = SimpleToken(
      payable(0x2360ffFEC1c80cA71B51E905870D7A1433746DD0)
    );

    uint256 balanceBefore = address(deployerAddress).balance;
    instance.destroy(payable(deployerAddress));
    console.log(balanceBefore, address(deployerAddress).balance);
    vm.stopBroadcast();
  }
}
