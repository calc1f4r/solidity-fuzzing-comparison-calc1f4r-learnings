// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../../src/01-naive-receiver/NaiveReceiverLenderPool.sol";
import "../../src/01-naive-receiver/FlashLoanReceiver.sol";


contract CalciferBasicEchidna  {
    NaiveReceiverLenderPool pool;
    FlashLoanReceiver flashLoanReceiver;

    constructor() {
        pool = new NaiveReceiverLenderPool();
        flashLoanReceiver = new FlashLoanReceiver(payable(address(pool)));

        (bool success, ) = address(pool).call{value: 10000 ether}("");
        require(success, "Failed to send ETH to pool");

        (bool success2, ) = address(flashLoanReceiver).call{value: 100 ether}("");
        require(success2, "Failed to send ETH to flashLoanReceiver");
    }

    function invariant_receiver_balance_not_zero() public view {
        assert(address(flashLoanReceiver).balance != 0);
    }   

    // 2) receiver's balance is not less than starting balance
    // breaking this invariant is less valuable but much easier
    function invariant_receiver_balance_not_less_initial() public view {
       assert(address(flashLoanReceiver).balance >= 100 ether);
    }
}