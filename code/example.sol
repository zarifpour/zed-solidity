// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // Declare a state variable to store an integer
    uint256 private storedData;

    // Event to log the storage of a new value
    event DataStored(uint256 newValue);

    // Custom error for invalid values
    error InvalidValue(uint256 value);

    // Modifier to check a condition before executing a function
    modifier validateValue(uint256 x) {
        if (x == 0) {
            revert InvalidValue(x);
        }
        _;
    }

    // Function to store a new value
    function set(uint256 x) private validateValue(x) {
        // Use inline assembly to store the new value
        assembly {
            sstore(storedData.slot, x)
        }
        emit DataStored(x);
    }

    // Function to retrieve the stored value
    function get() public view returns (uint256) {
        return storedData;
    }
}
