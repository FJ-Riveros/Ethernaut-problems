// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Elevator.sol";
import "../src/ElevatorExploit.sol";

contract ElevatorScript is Script {
  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    Elevator instance = new Elevator();
    ElevatorExploit exploit = new ElevatorExploit(instance);
    bool success = exploit.executeExploit();
    console.logBool(success);
    vm.stopBroadcast();
  }
}
