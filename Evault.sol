// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Evault {
    struct Record {
        string ipfsHash;
        address owner;
    }

    mapping(string => Record) public records;

    event DocumentStored(string ipfsHash, address owner);
    event OwnershipTransferred(string ipfsHash, address newOwner);

    function storeDocument(string memory _ipfsHash) public {
        require(records[_ipfsHash].owner == address(0), "Document already exists.");
        records[_ipfsHash] = Record(_ipfsHash, msg.sender);
        emit DocumentStored(_ipfsHash, msg.sender);
    }

    function transferOwnership(string memory _ipfsHash, address _newOwner) public {
        require(records[_ipfsHash].owner == msg.sender, "You are not the owner.");
        records[_ipfsHash].owner = _newOwner;
        emit OwnershipTransferred(_ipfsHash, _newOwner);
    }

    function verifyDocument(string memory _ipfsHash) public view returns (bool, address) {
        return (records[_ipfsHash].owner != address(0), records[_ipfsHash].owner);
    }
}
