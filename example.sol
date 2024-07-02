// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Contract to demonstrate different Solidity features and syntax
contract SimpleStorage {
    // State variable to store an integer
    uint256 private storedData;

    // Event to log the stored data changes
    event DataStored(uint256 data);

    // Function to store a new value
    function set(uint256 x) public {
        storedData = x;
        emit DataStored(x);
    }

    // Function to retrieve the stored value
    function get() public view returns (uint256) {
        for (uint256 i = 0; i < 10; i++) {
            // Example of inline assembly to perform an operation (no practical use here, just demonstration)
            assembly {
                let temp := i
                temp := add(temp, 1)
            }
        }
        return storedData;
    }
}

// Library to handle custom errors
library Errors {
    error InvalidTransfer(address from, address to, uint256 amount);
    error AddressZeroNotAllowed();
    error SameValue();
}

// Example of a contract using an ERC20 token from OpenZeppelin
contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000 * 10 ** uint256(decimals()));
    }

    // Function to transfer tokens with a custom error check
    function safeTransfer(address to, uint256 amount) public {
        if (amount == 0) {
            revert Errors.SameValue();
        }
        if (to == address(0)) {
            revert Errors.AddressZeroNotAllowed();
        }
        _transfer(msg.sender, to, amount);
    }
}
