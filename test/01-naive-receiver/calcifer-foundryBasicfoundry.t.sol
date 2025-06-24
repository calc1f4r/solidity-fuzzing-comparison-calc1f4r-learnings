// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../../src/01-naive-receiver/NaiveReceiverLenderPool.sol";
import "../../src/01-naive-receiver/FlashLoanReceiver.sol";
// import "forge-std/StdInvariant.sol";

contract CalciferFoundryBasicFoundry is  Test {

    NaiveReceiverLenderPool pool;
    FlashLoanReceiver flashLoanReceiver;

    function setUp() public {
        pool = new NaiveReceiverLenderPool();
        flashLoanReceiver = new FlashLoanReceiver(payable(address(pool)));

        vm.deal(address(pool), 10000 ether);
        vm.deal(address(flashLoanReceiver), 100 ether);
    }


    // not discoverable by the foundry fuzzer 
    function invariant_testFlashLoanReceivebalanceshouldnotbezero() public view {
        // the invariant is that the flashLoanReceiver balance is not 0 after all the calls 
        assert(address(flashLoanReceiver).balance != 0);
    }

    // discoverable by the foundry fuzzer 
    function invariant_testFlashLoanReceiverLessthanInitialBalance() public view {
        // The invariant is that the balance of the flashloan reciever should be greater then the intial balance
        assert(address(flashLoanReceiver).balance >= 100 ether);
    }
}
