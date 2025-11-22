; Solidity test function detection for Zed editor
; Detects functions starting with "test" or "testFail" in contract declarations

; Match test functions (test*, testFail*, invariant*)
(
  (function_definition
    name: (identifier) @run
    (#match? @run "^(test_)")
    (#set! tag solidity-test))
)

; Match entire contract for running all tests in a contract
(
  (contract_declaration
    name: (identifier) @run)
  (#set! tag solidity-contract-test)
)
