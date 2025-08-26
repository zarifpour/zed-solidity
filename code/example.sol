// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IERC20.sol";

/// @title Comprehensive Solidity Example
/// @author Test Author
/// @notice This contract demonstrates all major Solidity language features
/// @dev Used for testing syntax highlighting and language support
contract ComprehensiveExample is IERC20 {
    // =============================================================================
    // STATE VARIABLES
    // =============================================================================

    /// @notice Public constant string
    string public constant NAME = "Test Token";

    /// @notice Public immutable value set in constructor
    uint256 public immutable INITIAL_SUPPLY;

    /// @notice Private state variable
    uint256 private _totalSupply;

    /// @notice Transient storage variable (EIP-1153)
    uint256 transient tempValue;

    /// @notice Storage location examples
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    address[] public holders;

    /// @notice Various primitive types
    bool public isActive = true;
    int256 public signedNumber = -42;
    bytes32 public hash;
    bytes public data;
    address public owner;

    // =============================================================================
    // ENUMS AND STRUCTS
    // =============================================================================

    /// @notice Status enumeration
    enum Status {
        Inactive, // 0
        Active, // 1
        Paused, // 2
        Terminated // 3

    }

    /// @notice User information struct
    struct UserInfo {
        address user;
        uint256 balance;
        uint256 timestamp;
        Status status;
        bool isVerified;
    }

    /// @notice Nested struct example
    struct ComplexData {
        UserInfo info;
        mapping(uint256 => bool) flags;
        uint256[] scores;
    }

    // =============================================================================
    // EVENTS
    // =============================================================================

    /// @notice Custom event with mixed parameter types
    event CustomEvent(uint256 indexed id, address indexed user, string data, bytes32 hash, Status status);

    /// @notice Event with anonymous modifier
    event AnonymousEvent(bytes32 indexed data) anonymous;

    // =============================================================================
    // ERRORS
    // =============================================================================

    /// @notice Insufficient balance error
    error InsufficientBalance(uint256 requested, uint256 available);

    /// @notice Invalid address error
    error InvalidAddress();

    /// @notice Custom error with multiple parameters
    error InvalidOperation(address user, uint256 value, string reason);

    // =============================================================================
    // MODIFIERS
    // =============================================================================

    /// @notice Only owner modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    /// @notice Value validation modifier
    modifier validateAmount(uint256 amount) {
        if (amount == 0) {
            revert InvalidOperation(msg.sender, amount, "Zero amount");
        }
        _;
    }

    /// @notice Address validation modifier
    modifier validAddress(address addr) {
        if (addr == address(0)) {
            revert InvalidAddress();
        }
        _;
    }

    /// @notice Complex modifier with multiple parameters
    modifier whenActive(address user) {
        require(isActive, "Contract is not active");
        require(user != address(0), "Invalid user");
        _;
    }

    // =============================================================================
    // CONSTRUCTOR AND FALLBACK
    // =============================================================================

    /// @notice Contract constructor
    /// @param _initialSupply The initial token supply
    /// @param _owner The contract owner
    constructor(uint256 _initialSupply, address _owner) validAddress(_owner) validateAmount(_initialSupply) {
        INITIAL_SUPPLY = _initialSupply;
        _totalSupply = _initialSupply;
        owner = _owner;
        _balances[_owner] = _initialSupply;

        emit Transfer(address(0), _owner, _initialSupply);
    }

    /// @notice Receive function for plain Ether transfers
    receive() external payable {
        emit CustomEvent(block.timestamp, msg.sender, "Received Ether", keccak256("receive"), Status.Active);
    }

    /// @notice Fallback function
    fallback() external payable {
        emit CustomEvent(block.number, msg.sender, "Fallback called", keccak256(msg.data), Status.Active);
    }

    // =============================================================================
    // VIEW AND PURE FUNCTIONS
    // =============================================================================

    /// @notice Get total supply (view function)
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /// @notice Get balance of account (view function with parameter)
    function balanceOf(address account) public view override validAddress(account) returns (uint256) {
        return _balances[account];
    }

    /// @notice Get allowance between owner and spender
    function allowance(address tokenOwner, address spender) public view override returns (uint256) {
        return _allowances[tokenOwner][spender];
    }

    /// @notice Pure function example with mathematical operations
    function calculateFee(uint256 amount, uint256 rate) public pure returns (uint256 fee, uint256 remaining) {
        fee = amount * rate / 10000;
        remaining = amount - fee;

        // Demonstrate arithmetic operators
        uint256 doubled = amount * 2;
        uint256 halved = amount / 2;
        uint256 remainder = amount % 3;
        uint256 power = amount ** 2;

        return (fee, remaining);
    }

    /// @notice Function with multiple return values and complex logic
    function getAccountInfo(address account)
        public
        view
        returns (uint256 balance, uint256 allowanceSum, bool hasBalance, Status accountStatus)
    {
        balance = _balances[account];
        hasBalance = balance > 0;
        accountStatus = hasBalance ? Status.Active : Status.Inactive;

        // Calculate total allowances given by this account
        allowanceSum = 0;
        for (uint256 i = 0; i < holders.length; i++) {
            allowanceSum += _allowances[account][holders[i]];
        }

        return (balance, allowanceSum, hasBalance, accountStatus);
    }

    // =============================================================================
    // STATE-CHANGING FUNCTIONS
    // =============================================================================

    /// @notice Transfer tokens with full validation
    function transfer(address to, uint256 amount)
        public
        override
        validAddress(to)
        validateAmount(amount)
        whenActive(msg.sender)
        returns (bool)
    {
        address from = msg.sender;
        _transfer(from, to, amount);
        return true;
    }

    /// @notice Approve spender to use tokens
    function approve(address spender, uint256 amount) public override validAddress(spender) returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    /// @notice Transfer from approved amount
    function transferFrom(address from, address to, uint256 amount)
        public
        override
        validAddress(from)
        validAddress(to)
        validateAmount(amount)
        returns (bool)
    {
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /// @notice Mint new tokens (only owner)
    function mint(address to, uint256 amount) public onlyOwner validAddress(to) validateAmount(amount) {
        _totalSupply += amount;
        _balances[to] += amount;

        emit Transfer(address(0), to, amount);
    }

    /// @notice Burn tokens from account
    function burn(uint256 amount) public validateAmount(amount) {
        address account = msg.sender;
        uint256 accountBalance = _balances[account];

        if (accountBalance < amount) {
            revert InsufficientBalance(amount, accountBalance);
        }

        // Demonstrate unchecked arithmetic block
        unchecked {
            _balances[account] = accountBalance - amount;
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);
    }

    // =============================================================================
    // INTERNAL FUNCTIONS
    // =============================================================================

    /// @notice Internal transfer function with validation
    function _transfer(address from, address to, uint256 amount) internal {
        uint256 fromBalance = _balances[from];

        if (fromBalance < amount) {
            revert InsufficientBalance(amount, fromBalance);
        }

        // Safe arithmetic in unchecked block
        unchecked {
            _balances[from] = fromBalance - amount;
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);
    }

    /// @notice Internal approve function
    function _approve(address tokenOwner, address spender, uint256 amount) internal {
        _allowances[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);
    }

    /// @notice Internal allowance spending function
    function _spendAllowance(address tokenOwner, address spender, uint256 amount) internal {
        uint256 currentAllowance = _allowances[tokenOwner][spender];

        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < amount) {
                revert InsufficientBalance(amount, currentAllowance);
            }

            unchecked {
                _approve(tokenOwner, spender, currentAllowance - amount);
            }
        }
    }

    // =============================================================================
    // ASSEMBLY AND LOW-LEVEL OPERATIONS
    // =============================================================================

    /// @notice Function demonstrating inline assembly
    function getCodeSize(address addr) public view returns (uint256 size) {
        assembly {
            size := extcodesize(addr)
        }
    }

    /// @notice Assembly example with memory operations
    function assemblyExample(bytes calldata _data) public pure returns (bytes32 result) {
        assembly {
            // Load data from calldata
            let len := _data.length
            let dataPtr := _data.offset

            // Memory operations
            let memPtr := mload(0x40)
            calldatacopy(memPtr, dataPtr, len)

            // Hash the data
            result := keccak256(memPtr, len)

            // Update free memory pointer
            mstore(0x40, add(memPtr, len))
        }
    }

    /// @notice Low-level call example
    function callExternal(address target, bytes calldata _data)
        external
        payable
        onlyOwner
        returns (bool success, bytes memory returnData)
    {
        (success, returnData) = target.call{value: msg.value}(_data);

        if (!success) {
            // Bubble up the revert reason
            assembly {
                let size := mload(returnData)
                revert(add(returnData, 0x20), size)
            }
        }
    }

    // =============================================================================
    // TRY/CATCH AND ERROR HANDLING
    // =============================================================================

    /// @notice Function demonstrating try/catch with external calls
    function safeBatchTransfer(address[] calldata recipients, uint256[] calldata amounts)
        external
        returns (bool[] memory results)
    {
        require(recipients.length == amounts.length, "Array length mismatch");
        results = new bool[](recipients.length);

        for (uint256 i = 0; i < recipients.length; i++) {
            try this.transfer(recipients[i], amounts[i]) returns (bool success) {
                results[i] = success;
            } catch Error(string memory reason) {
                emit CustomEvent(i, recipients[i], reason, keccak256(bytes(reason)), Status.Paused);
                results[i] = false;
            } catch Panic(uint256 errorCode) {
                emit CustomEvent(i, recipients[i], "Panic occurred", bytes32(errorCode), Status.Terminated);
                results[i] = false;
            } catch (bytes memory lowLevelData) {
                emit CustomEvent(i, recipients[i], "Unknown error", keccak256(lowLevelData), Status.Inactive);
                results[i] = false;
            }
        }

        return results;
    }

    /// @notice Try/catch with contract creation
    function deployContract(bytes memory bytecode, uint256 salt) external onlyOwner returns (address deployedAddress) {
        try new DeployedContract{salt: bytes32(salt)}() returns (DeployedContract newContract) {
            deployedAddress = address(newContract);
            emit CustomEvent(salt, deployedAddress, "Contract deployed", bytes32(salt), Status.Active);
        } catch Error(string memory reason) {
            revert InvalidOperation(msg.sender, salt, reason);
        } catch (bytes memory) {
            revert InvalidOperation(msg.sender, salt, "Deployment failed");
        }
    }

    // =============================================================================
    // ADVANCED FEATURES
    // =============================================================================

    /// @notice Function with function selector and ABI encoding
    function encodeFunctionCall(address target, uint256 amount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(IERC20.transfer.selector, target, amount);
    }

    /// @notice Function demonstrating type conversions
    function typeConversions(uint128 smallNumber) public pure returns (uint256, bytes32, address) {
        // Implicit conversion
        uint256 bigNumber = smallNumber;

        // Explicit conversions
        bytes32 numberAsBytes = bytes32(uint256(smallNumber));
        address numberAsAddress = address(uint160(smallNumber));

        return (bigNumber, numberAsBytes, numberAsAddress);
    }

    /// @notice Function with payable and value operations
    function payableFunction() external payable {
        require(msg.value > 0, "Must send Ether");

        // Store in transient storage for gas optimization
        tempValue = msg.value;

        // Access transaction properties
        uint256 value = msg.value;
        address sender = msg.sender;
        bytes memory data = msg.data;
        uint256 gasLeft = gasleft();

        // Block properties
        uint256 timestamp = block.timestamp;
        uint256 blockNumber = block.number;
        address coinbase = block.coinbase;
        uint256 difficulty = block.difficulty;
        uint256 gasLimit = block.gaslimit;
        bytes32 blockHash = blockhash(blockNumber - 1);

        emit CustomEvent(
            blockNumber,
            sender,
            "Payable function called",
            keccak256(abi.encodePacked(value, gasLeft, timestamp)),
            Status.Active
        );
    }

    /// @notice Function with complex control flow
    function complexControlFlow(uint256 input) public pure returns (string memory result) {
        // If-else chains
        if (input < 10) {
            result = "Small";
        } else if (input < 100) {
            result = "Medium";
        } else if (input < 1000) {
            result = "Large";
        } else {
            result = "Very Large";
        }

        // For loop
        for (uint256 i = 0; i < 3; i++) {
            if (i == 1) {
                continue;
            }
            if (i == 2) {
                break;
            }
        }

        // While loop with unchecked arithmetic for gas optimization
        uint256 counter = input;
        while (counter > 0 && counter < 1000000) {
            unchecked {
                counter = counter * 2;
            }
            if (counter > 100000) {
                break;
            }
        }

        // Do-while loop
        do {
            counter = counter / 2;
        } while (counter > 10);

        return result;
    }

    // =============================================================================
    // LIBRARY USAGE AND FUNCTION TYPES
    // =============================================================================

    /// @notice Function demonstrating library usage
    function libraryUsage(uint256 a, uint256 b) public pure returns (uint256 sum, uint256 product) {
        // Using basic arithmetic
        sum = a + b;
        product = a * b;

        return (sum, product);
    }

    /// @notice Function with function pointers (external function type)
    function functionPointerExample() public view returns (uint256) {
        // Function type variable
        function(address) external view returns (uint256) balanceFunction = this.balanceOf;

        return balanceFunction(msg.sender);
    }
}

// =============================================================================
// INTERFACES
// =============================================================================

/// @notice Example interface
interface IExampleInterface {
    /// @notice Interface function declaration
    function exampleFunction(uint256 param) external returns (bool);

    /// @notice Interface event declaration
    event InterfaceEvent(address indexed user, uint256 value);
}

// =============================================================================
// LIBRARIES
// =============================================================================

/// @notice Example library
library ExampleLibrary {
    /// @notice Library function
    function exampleLibraryFunction(uint256 value) internal pure returns (uint256) {
        return value * 2;
    }

    /// @notice Library function using 'using for'
    function double(uint256 value) internal pure returns (uint256) {
        return value * 2;
    }
}

// =============================================================================
// ADDITIONAL CONTRACTS
// =============================================================================

/// @notice Abstract contract example
abstract contract AbstractExample {
    /// @notice Abstract function that must be implemented
    function abstractFunction() public virtual returns (uint256);

    /// @notice Concrete function in abstract contract
    function concreteFunction() public pure returns (string memory) {
        return "Concrete implementation";
    }
}

/// @notice Contract for deployment testing
contract DeployedContract {
    address public creator;

    constructor() {
        creator = msg.sender;
    }
}

/// @notice Contract demonstrating inheritance
contract InheritanceExample is AbstractExample, IExampleInterface {
    /// @notice Override abstract function
    function abstractFunction() public pure override returns (uint256) {
        return 42;
    }

    /// @notice Implement interface function
    function exampleFunction(uint256 param) external pure override returns (bool) {
        return param * 2 > 0;
    }

    /// @notice Virtual function that can be overridden
    function virtualFunction() public pure virtual returns (string memory) {
        return "Base implementation";
    }
}

/// @notice Final contract in inheritance chain
contract FinalContract is InheritanceExample {
    /// @notice Override virtual function
    function virtualFunction() public pure override returns (string memory) {
        return "Final implementation";
    }
}
