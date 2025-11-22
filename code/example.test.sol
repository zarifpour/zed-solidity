// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "./example.sol";

contract ComprehensiveExampleTest is Test {
    ComprehensiveExample public token;
    address public owner;
    address public alice;
    address public bob;
    uint256 public constant INITIAL_SUPPLY = 1_000_000e18;

    // Events to test against
    event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() public {
        // validAddress modifier checks for address(0), so we set a real owner
        owner = address(this);
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        // Deploy the contract with initial supply and owner
        token = new ComprehensiveExample(INITIAL_SUPPLY, owner);
    }

    function test_InitialState() public {
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY);
        assertEq(token.owner(), owner);
        console.log("stuff!!!");
    }

    function test_Transfer() public {
        uint256 amount = 1000e18;

        // Owner transfers to Alice
        token.transfer(alice, amount);

        assertEq(token.balanceOf(alice), amount);
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY - amount);
    }

    function test_Transfer_EmitEvent() public {
        uint256 amount = 500e18;

        vm.expectEmit(true, true, false, true);
        emit Transfer(owner, alice, amount);

        token.transfer(alice, amount);
    }

    function test_Mint_AsOwner() public {
        uint256 amount = 500e18;

        token.mint(alice, amount);

        assertEq(token.balanceOf(alice), amount);
        assertEq(token.totalSupply(), INITIAL_SUPPLY + amount);
    }

    function test_RevertWhen_MintNotOwner() public {
        uint256 amount = 500e18;

        // Prank Alice (make next call come from Alice)
        vm.prank(alice);

        // Expect the "Not the owner" require message from onlyOwner modifier
        vm.expectRevert("Not the owner");
        token.mint(alice, amount);
    }

    function test_Burn() public {
        uint256 burnAmount = 100e18;

        token.burn(burnAmount);

        assertEq(token.totalSupply(), INITIAL_SUPPLY - burnAmount);
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY - burnAmount);
    }

    function test_RevertWhen_BurnInsufficientBalance() public {
        uint256 burnAmount = INITIAL_SUPPLY + 1;

        // Expect the custom error InsufficientBalance(requested, available)
        vm.expectRevert(
            abi.encodeWithSelector(
                ComprehensiveExample.InsufficientBalance.selector,
                burnAmount,
                INITIAL_SUPPLY
            )
        );
        token.burn(burnAmount);
    }

    // Fuzz testing example
    function testFuzz_Transfer(uint256 amount) public {
        // Constrain fuzz inputs to valid amounts
        vm.assume(amount > 0 && amount <= INITIAL_SUPPLY);

        token.transfer(alice, amount);
        assertEq(token.balanceOf(alice), amount);
    }
}
