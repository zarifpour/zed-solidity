// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title ERC20 Interface
/// @notice Interface for the ERC20 standard token contract
/// @dev Standard ERC20 interface as defined in EIP-20
interface IERC20 {
    // =============================================================================
    // EVENTS
    // =============================================================================

    /// @notice Emitted when tokens are transferred
    /// @param from The address tokens are transferred from
    /// @param to The address tokens are transferred to
    /// @param value The amount of tokens transferred
    event Transfer(address indexed from, address indexed to, uint256 value);

    /// @notice Emitted when an allowance is set
    /// @param owner The address that owns the tokens
    /// @param spender The address that is approved to spend the tokens
    /// @param value The amount of tokens approved for spending
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // =============================================================================
    // VIEW FUNCTIONS
    // =============================================================================

    /// @notice Returns the total supply of tokens
    /// @return The total amount of tokens in existence
    function totalSupply() external view returns (uint256);

    /// @notice Returns the balance of an account
    /// @param account The address to check the balance for
    /// @return The amount of tokens owned by the account
    function balanceOf(address account) external view returns (uint256);

    /// @notice Returns the remaining number of tokens that spender is allowed to spend
    /// @param owner The address that owns the tokens
    /// @param spender The address that is approved to spend the tokens
    /// @return The amount of tokens the spender is still allowed to spend
    function allowance(address owner, address spender) external view returns (uint256);

    // =============================================================================
    // STATE-CHANGING FUNCTIONS
    // =============================================================================

    /// @notice Transfers tokens to a specified address
    /// @param to The address to transfer tokens to
    /// @param amount The amount of tokens to transfer
    /// @return True if the transfer was successful
    function transfer(address to, uint256 amount) external returns (bool);

    /// @notice Approves another address to spend tokens on behalf of the caller
    /// @param spender The address to approve for spending
    /// @param amount The amount of tokens to approve for spending
    /// @return True if the approval was successful
    function approve(address spender, uint256 amount) external returns (bool);

    /// @notice Transfers tokens from one address to another using an allowance
    /// @param from The address to transfer tokens from
    /// @param to The address to transfer tokens to
    /// @param amount The amount of tokens to transfer
    /// @return True if the transfer was successful
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
