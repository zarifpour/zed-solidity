; Literals
; --------

[
 (string)
 (hex_string_literal)
 (unicode_string_literal)
 (yul_string_literal)
] @string

(hex_string_literal
  "hex" @string.special.symbol
  )

(unicode_string_literal
  "unicode" @string.special.symbol
  )

[
 (number_literal)
 (yul_decimal_number)
 (yul_hex_number)
] @number

[
 (true)
 (false)
] @constant.builtin

(yul_boolean) @boolean.constant

(comment) @comment

; --------
; end Literals

; Definitions and references
; -----------

; Variables
[
  (identifier)
  (yul_identifier)
] @variable

; Types
(type_name) @type
(primitive_type) @type
(user_defined_type (identifier) @type)
["assembly"] @type

(payable_conversion_expression "payable" @type)
; Ensures that delimiters in mapping( ... => .. ) are not colored like types
(type_name "(" @punctuation.bracket "=>" @punctuation.delimiter ")" @punctuation.bracket)

; Definitions
(struct_declaration
  name: (identifier) @type)
(enum_declaration
  name: (identifier) @type)
(contract_declaration
  name: (identifier) @type)
(library_declaration
  name: (identifier) @type)
(interface_declaration
  name: (identifier) @type)
(event_definition
  name: (identifier) @type)

(function_definition
  name:  (identifier) @function)

(modifier_definition
  name:  (identifier) @function)
(yul_evm_builtin) @function.builtin

; Use constructor coloring for special functions
(constructor_definition "constructor" @constructor)
(fallback_receive_definition "receive" @constructor)
(fallback_receive_definition "fallback" @constructor)

(struct_member name: (identifier) @property)
(enum_value) @constant

; Invocations
(emit_statement . (identifier) @type)
(modifier_invocation (identifier) @function)

(call_expression . (member_expression property: (identifier) @function.method))
(call_expression . (identifier) @function)

; Function parameters
(call_struct_argument name: (identifier) @property)
(event_paramater name: (identifier) @variable.parameter)
(parameter name: (identifier) @variable.parameter)

; Yul functions
(yul_function_call function: (yul_identifier) @function)
(yul_function_definition . (yul_identifier) @function (yul_identifier) @variable.parameter)

; Structs and members
(member_expression property: (identifier) @property)
(struct_expression type: ((identifier) @type .))
(struct_field_assignment name: (identifier) @property)


; Tokens
; -------

; Keywords
(meta_type_expression "type" @keyword)
; Keywords
[
    "calldata"
    "catch"
    "constant"
    "contract"
    "do"
    "emit"
    "enum"
    "event"
    "for"
    "interface"
    "is"
    "library"
    "memory"
    "modifier"
    "pragma"
    "pure"
    "storage"
    "struct"
    "try"
    "using"
    "var"
    "view"
    "while"
    (immutable)
    (yul_variable_declaration)
    (virtual)
    (override_specifier)
    (yul_leave)
] @keyword

[
  "abstract"
  (visibility)
] @constructor

[
  "payable"
  "public"
] @constant

[
    (virtual)
    (override_specifier)
] @operator

; Color immutable and constant variables as constants
[
    (state_variable_declaration
        (type_name)
        (visibility) @keyword
        (immutable) @keyword
        (identifier) @constant)

    (state_variable_declaration
        (type_name)
        "constant" @keyword
        (identifier) @constant)
]

(state_variable_declaration
  (type_name)
  (visibility ("public" @keyword)))

(state_variable_declaration
  (type_name)
  (visibility ("private" @keyword)))

(state_variable_declaration
  (type_name)
  (visibility ("internal" @keyword)))

(state_variable_declaration
  (type_name)
  (visibility ("external" @keyword)))

[
  "view"
  "pure"
] @tag

[
 "break"
 "continue"
 "if"
 "else"
 "switch"
 "case"
 "default"
] @conditional

[
 "try"
 "catch"
] @exception

[
 "return"
 "returns"
] @keyword.return

"function" @keyword.function

"import" @include
(import_directive "as" @include)
(import_directive "from" @include)

(event_paramater "indexed" @keyword)

; Punctuation

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket


[
  "."
  ","
] @punctuation.delimiter


; Operators

[
  "&&"
  "||"
  ">>"
  ">>>"
  "<<"
  "&"
  "^"
  "|"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "<"
  "<="
  "=="
  "!="
  "!=="
  ">="
  ">"
  "!"
  "~"
  "-"
  "+"
  "++"
  "--"
  "+="
  "-="
  "="
  "*="
  ":="
] @operator

[
  "delete"
  "new"
] @keyword.operator

[
 "break"
 "continue"
 "if"
 "else"
 "switch"
 "case"
 "default"
] @keyword.conditional

[
 "for"
]
@keyword.repeat

[
  "?"
  ":"
] @keyword.operator

[
  "revert"
] @keyword.revert

[
  "error"
] @keyword.error

; Pragma
; --------

[
  "pragma"
  "solidity"
] @keyword.directive

(pragma_directive) @primary

[
    (solidity_pragma_token
    "||" @string.special.symbol)

    (solidity_pragma_token
        "-" @string.special.symbol)
]

(solidity_version) @string.special

[
    (solidity_version_comparison_operator) @string.special.symbol
    (solidity_version_comparison_operator
        ">=" @string.special.symbol)
    (solidity_version_comparison_operator
        "=" @string.special.symbol)
    (solidity_version_comparison_operator
        ">" @string.special.symbol)
    (solidity_version_comparison_operator
        "<=" @string.special.symbol)
    (solidity_version_comparison_operator
        "<" @string.special.symbol)
    (solidity_version_comparison_operator
        "^" @string.special.symbol)
    (solidity_version_comparison_operator
        "~" @string.special.symbol)
]

; --------
; end Pragma

; Additional rules
; --------

(expression_statement (call_expression . function: (identifier) @constructor))
(try_statement "try" @keyword)
(catch_clause "catch" @keyword)
(call_expression function: (member_expression property: (identifier) @function))
(error_declaration name: (identifier) @constant)
(event_definition name: (identifier) @tag)
(revert_statement error: (identifier) @constant)
(revert_statement "revert" @constructor)
(emit_statement name: (identifier) @tag)
(emit_statement "emit" @boolean)
(user_defined_type (identifier)) @variable

; --------
; end Additional rules
