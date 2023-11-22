
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";

import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    function run() external {
        // vm.startBroadcast();
        bytes32 counterInitCodeHash = keccak256(type(Counter).creationCode);

        console2.log("Counter initCodeHash: ");
        console2.logBytes32(counterInitCodeHash);

        // $ cast create2 --starts-with 0x000000 --init-code-hash 0x479d7e8f31234e208d704ba1a123c76385cea8a6981fd675b784fbd9cffb918d
        //
        // Starting to generate deterministic contract address...
        // Successfully found contract address(es) in 2.492678083s
        // Address: 0x0000002e9eEF048A3ccDf115aF53A51Ae312870d
        // Salt: 0x0000000000000000000000000000000000000000000000006d3aaf0100000000 (7870795717613191168)

        address expectedAddress = address(0x0000002e9eEF048A3ccDf115aF53A51Ae312870d);
        bytes32 salt = bytes32(0x0000000000000000000000000000000000000000000000006d3aaf0100000000);

        Counter counter = new Counter{salt: salt}();
        console2.log("Counter address: %s", address(counter));

        require(address(counter) == expectedAddress, "Counter address mismatch");

        // vm.stopBroadcast();
    }
}
