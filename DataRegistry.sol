// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataRegistry {
    address public owner;
    struct DataEntry {
        uint timestamp;
        bool exists;
    }
    mapping(bytes32 => DataEntry) public dataHashes;
    event HashStored(address indexed sender, bytes32 hash, uint timestamp);

    constructor() {
        owner = msg.sender;
    }

    function storeHash(bytes32 _hash) public {
        require(msg.sender == owner, "Only owner can store hashes");
        require(!dataHashes[_hash].exists, "Hash already exists");
        dataHashes[_hash] = DataEntry(block.timestamp, true);
        emit HashStored(msg.sender, _hash, block.timestamp);
    }

    function verifyHash(bytes32 _hash) public view returns (bool exists, uint timestamp) {
        return (dataHashes[_hash].exists, dataHashes[_hash].timestamp);
    }
}