; Literals
(string_literal) @string
(decimal_number) @number
(hex_number) @number
(true) @boolean
(false) @boolean

; Identifiers
(identifier) @variable

; Types
(type_name) @type

; Functions
(function_definition
  name: (identifier) @function)

(function_call
  function: (identifier) @function.call)

(evm_builtin) @function.builtin

; Function parameters
(function_definition
  (typed_identifier_list
    (identifier) @variable.parameter))

; Keywords
[
  "let"
] @keyword

[
  "function"
] @keyword.function

[
  "for"
  "break"
  "continue"
] @keyword.repeat

[
  "if"
  "switch"
  "case"
  "default"
] @keyword.conditional

[
  "leave"
] @keyword.return

; Object notation
[
  "object"
  "code"
  "data"
] @keyword

(hex_literal
  "hex" @string.special.symbol)

; Operators
":=" @operator

; Punctuation
["{" "}"] @punctuation.bracket
["(" ")"] @punctuation.bracket
["," ":" "->"] @punctuation.delimiter

; Comments
(comment) @comment
