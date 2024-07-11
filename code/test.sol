// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0 || ^0.8.0-; // Using pragma with version comparison operators

// Import statements
import "./AnotherContract.sol";
import "./AnotherLibrary.sol" as Lib;
import "./SomeInterface.sol";
import { Example } from "./Example.sol";


contract IdentifierExamples {
    // State variables
    string public stringLiteral = "Hello, world!";  // (identifier) @variable
    bytes public hexStringLiteral = hex"48656c6c6f2c20776f726c6421";  // (identifier) @variable
    string private unicodeStringLiteral = unicode"Hello, 🌍!";  // (identifier) @variable
    uint public numberLiteral = 12345;  // (identifier) @variable

    // Struct definition
    struct MyStruct {
        uint id;  // (identifier) @variable
        string data;  // (identifier) @variable
    }

    // Enum definition
    enum MyEnum {
        Option1,  // (identifier) @variable
        Option2,  // (identifier) @variable
        Option3  // (identifier) @variable
    }

    // State variables for struct and enum
    MyStruct public myStruct;  // (identifier) @variable
    MyEnum public myEnum;  // (identifier) @variable

    // Constructor
    constructor() {
        myStruct = MyStruct({id: 1, data: "Struct data"});  // (identifier) @variable
        myEnum = MyEnum.Option1;  // (identifier) @variable
    }

    // Function with local variables
    function exampleFunction(uint _value) public returns (uint) {  // (identifier) @variable
        uint localValue = _value * 2;  // (identifier) @variable
        return localValue;  // (identifier) @variable
    }

    // Yul block with Yul identifiers
    function yulExample(uint _a, uint _b) public pure returns (uint) {  // (identifier) @variable
        assembly {
            let a := _a  // (yul_identifier) @variable
            let b := _b  // (yul_identifier) @variable
            let result := add(a, b)  // (yul_identifier) @variable
            mstore(0x40, result)  // (yul_identifier) @variable
            return(0x40, 0x20)  // (yul_identifier) @variable
        }
    }

    // Function with loop and nested function call
    function loopExample(uint[] memory data) public pure returns (uint) {  // (identifier) @variable
        uint sum = 0;  // (identifier) @variable
        for (uint i = 0; i < data.length; i++) {  // (identifier) @variable
            sum += data[i];  // (identifier) @variable
        }
        return sum;  // (identifier) @variable
    }

    // Using enum
    function setEnumOption(uint _option) public {  // (identifier) @variable
        require(_option <= uint(MyEnum.Option3), "Invalid option");  // (identifier) @variable
        myEnum = MyEnum(_option);  // (identifier) @variable
    }

    // Using struct
    function setStruct(uint _id, string memory _data) public {  // (identifier) @variable
        myStruct = MyStruct({id: _id, data: _data});  // (identifier) @variable
    }
}

contract LiteralExamples {
    // String Literals
    string public stringLiteral = "Hello, world!";

    // Yul String Literal
    function yulStringLiteral() private pure returns (string memory) {
        assembly {
            let str := "Yul string literal"
            mstore(0x40, str)
            return(0x40, 0x20)
        }
    }

    // Hex String Literal
    bytes public hexStringLiteral = hex"48656c6c6f2c20776f726c6421";

    // Unicode String Literal
    string public unicodeStringLiteral = unicode"Hello, 🌍!";

    // Number Literals
    uint public numberLiteral = 12345;

    // Yul Decimal Number
    function yulDecimalNumber() public pure returns (uint) {
        assembly {
            let num := 12345
            mstore(0x40, num)
            return(0x40, 0x20)
        }
    }

    // Yul Hex Number
    function yulHexNumber() public pure returns (uint) {
        assembly {
            let num := 0x3039 // 12345 in hexadecimal
            mstore(0x40, num)
            return(0x40, 0x20)
        }
    }

    // Yul Boolean
    function yulBoolean() public pure returns (bool) {
        assembly {
            let boolVal := true
            mstore(0x40, boolVal)
            return(0x40, 0x20)
        }
    }
}

// Library definition
library MathLib {
    function max(uint a, uint b) internal pure returns (uint) {
        return a >= b ? a : b;
    }
}

// Interface definition
interface IExample {
    function exampleFunction(uint a) external returns (uint);
}

// Abstract contract
abstract contract AbstractContract {
    function abstractFunction() public view virtual returns (string memory);
}

// Contract inheritance
contract BaseContract {
    uint public baseValue;

    function setBaseValue(uint _value) public {
        baseValue = _value;
    }
}

// Multi-level inheritance
contract IntermediateContract is BaseContract {
    function intermediateFunction() public pure returns (string memory) {
        return "Intermediate function";
    }
}

// Main contract
contract MainContract is AbstractContract, IntermediateContract {
    // State variables
    uint public value;
    string private name;
    address immutable owner;
    uint256[] public numbers;
    mapping(address => uint256) public balances;
    bool private active;
    bytes32 constant MY_CONSTANT = "MY_CONSTANT_VALUE";
    mapping(address => mapping(uint => bool)) nestedMapping;

    // Events
    event ValueChanged(uint indexed oldValue, uint indexed newValue);
    event Received(address, uint);
    event NestedMappingUpdated(address indexed account, uint indexed key, bool value);

    // Struct definition
    struct MyStruct {
        uint id;
        string data;
    }

    // Enum definition
    enum MyEnum {
        Option1,
        Option2,
        Option3
    }

    // Modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Constructor
    constructor(string memory _name) {
        owner = msg.sender;
        name = _name;
    }

    // Fallback and receive functions
    fallback() external payable {
        emit Received(msg.sender, msg.value);
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
        require(msg.value);
    }

    // Public function
    function setValue(uint _value) public onlyOwner {
        emit ValueChanged(value, _value);
        value = _value;
    }

    // External function
    function externalFunction() external view returns (string memory) {
        return name;
    }

    // Internal function
    function internalFunction(uint a, uint b) internal pure returns (uint) {
        return MathLib.max(a, b);
    }

    // Private function
    function privateFunction() private view returns (address) {
        return owner;
    }

    // Pure function
    function pureFunction(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    // View function
    function viewFunction() public view returns (uint) {
        return value;
    }

    // Using a library for a struct
    using MathLib for uint;

    // Using assembly
    function assemblyFunction(uint x, uint y) public pure returns (uint result) {
        assembly {
            result := add(x, y)
        }
    }

    // Override function from abstract contract
    function abstractFunction() public view override returns (string memory) {
        return "Abstract function implemented";
    }

    // Using enum
    MyEnum public myEnum;

    function setEnumOption(uint _option) public {
        require(_option <= uint(MyEnum.Option3), "Invalid option");
        myEnum = MyEnum(_option);
    }

    // Using struct
    MyStruct public myStruct;

    function setStruct(uint _id, string memory _data) public {
        myStruct = MyStruct({id: _id, data: _data});
    }

    // Using array
    function addNumber(uint _number) public {
        numbers.push(_number);
    }

    // Using mapping
    function updateBalance(address _address, uint256 _amount) public {
        balances[_address] = _amount;
    }

    // Nested mapping
    function updateNestedMapping(address _account, uint _key, bool _value) public {
        nestedMapping[_account][_key] = _value;
        emit NestedMappingUpdated(_account, _key, _value);
    }

    // Function with try/catch
    function tryCatchExample(IExample example, uint _a) public returns (uint) {
        try example.exampleFunction(_a) returns (uint result) {
            return result;
        } catch {
            return 0;
        }
    }

    // Custom errors
    error Unauthorized(address caller);
    error InvalidInput(string reason);

    function checkAuthorization() public view {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
    }

    function validateInput(uint _value) public pure {
        if (_value == 0) {
            revert InvalidInput("Value cannot be zero");
        }
    }

    // Function overloading
    function overloadedFunction(uint _value) public pure returns (uint) {
        return _value * 2;
    }

    function overloadedFunction(uint _value, uint _multiplier) public pure returns (uint) {
        return _value * _multiplier;
    }

    // Payable function
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Error handling with assert
    function assertExample(uint _value) public pure returns (uint) {
        assert(_value > 0);
        return _value;
    }

    // Error handling with require
    function requireExample(uint _value) public pure returns (uint) {
        require(_value > 0, InvalidInput("because"));
        return _value;
    }

    // Error handling with revert
    function revertExample(uint _value) public pure {
        if (_value == 0) {
            revert("Value cannot be zero");
        }
    }

    // Using immutable
    function getOwner() public view returns (address) {
        return owner;
    }

    // Using constants
    function getConstant() public pure returns (bytes32) {
        return MY_CONSTANT;
    }

    // Constructor overloading
    constructor(string memory _name, uint _initialValue) {
        owner = msg.sender;
        name = _name;
        value = _initialValue;
    }

    // Assembly to perform bitwise operations
    function bitwiseAnd(uint a, uint b) public pure returns (uint) {
        uint result;
        assembly {
            result := and(a, b)
        }
        return result;
    }

    function bitwiseOr(uint a, uint b) public pure returns (uint) {
        uint result;
        assembly {
            result := or(a, b)
        }
        return result;
    }

    function bitwiseXor(uint a, uint b) public pure returns (uint) {
        uint result;
        assembly {
            result := xor(a, b)
        }
        return result;
    }

    function bitwiseNot(uint a) public pure returns (uint) {
        uint result;
        assembly {
            result := not(a)
        }
        return result;
    }

    // Use of delegatecall
    function delegateCallExample(address callee, bytes memory data) public returns (bytes memory) {
        (bool success, bytes memory result) = callee.delegatecall(data);
        require(success, "Delegatecall failed");
        return result;
    }

    // Use of call
    function callExample(address callee, bytes memory data) public returns (bytes memory) {
        (bool success, bytes memory result) = callee.call(data);
        require(success, "Call failed");
        return result;
    }

    // Use of staticcall
    function staticCallExample(address callee, bytes memory data) public view returns (bytes memory) {
        (bool success, bytes memory result) = callee.staticcall(data);
        require(success, "Staticcall failed");
        return result;
    }

    // For loop
    function forLoopExample() public view returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }

    // While loop
    function whileLoopExample() public view returns (uint) {
        uint sum = 0;
        uint i = 0;
        while (i < numbers.length) {
            sum += numbers[i];
            i++;
        }
        return sum;
    }

    // Do-while loop
    function doWhileLoopExample() public view returns (uint) {
        uint sum = 0;
        uint i = 0;
        if (numbers.length == 0) {
            return sum;
        }
        do {
            sum += numbers[i];
            i++;
        } while (i < numbers.length);
        return sum;
    }

    // Using tuples
    function tupleExample() public pure returns (uint, string memory, bool) {
        return (1, "Tuple", true);
    }

    // Function to demonstrate interaction with another contract
    function interactWithERC20(IERC20 token, address recipient, uint256 amount) public {
        require(token.transfer(recipient, amount), "Transfer failed");
    }

    // Function to demonstrate use of storage pointers
    function storagePointerExample() public view returns (uint256) {
        uint256[] storage nums = numbers;
        return nums.length;
    }

    // Function to demonstrate use of memory pointers
    function memoryPointerExample() public view returns (uint256) {
        uint256[] memory nums = numbers;
        return nums.length;
    }

    // Inline assembly for more complex operations
    function assemblyComplexOperation(uint a, uint b) public pure returns (uint result) {
        assembly {
            let temp := add(a, b)
            result := mul(temp, 2)
        }
    }

    // Using .call() to send ether
    function sendEther(address payable recipient) public payable {
        (bool success, ) = recipient.call{value: msg.value}("");
        require(success, "Ether transfer failed");
    }

    // Using interface
    function callExampleFunction(IExample example, uint a) public returns (uint) {
        return example.exampleFunction(a);
    }

    // Check balance of ERC20 token using interface
    function checkERC20Balance(IERC20 token, address account) public view returns (uint256) {
        return token.balanceOf(account);
    }
}
