;; Sometimes we want to indicate that certain parts of our source text should
;; not be formatted, but taken as is. We use the leaf capture name to inform the
;; tool of this.
(integer_value) @leaf
(plain_value) @leaf
(string_value) @leaf

; Append space after colons
(declaration ":" @append_space)

; Add space before any !important declarations
(important) @prepend_space

; Spacing before and after a rule_set
(rule_set) @allow_blank_line_before
(rule_set) @prepend_hardline

; Allow comments to have a blank line before them
(comment) @allow_blank_line_before

; Allow blank lines before any declaration in a block except the first one
(block . (declaration) (declaration) @allow_blank_line_before)

; Space before curly and after selectors
[(selectors)] @append_space
(descendant_selector
  (_) @append_space
  .
  (_)
)
(sibling_selector
  (_) @append_space
  "~" @append_space
  (_)
)
(adjacent_sibling_selector
  (_) @append_space
  "+" @append_space
  (_)
)
(child_selector
  (_) @append_space
  ">" @append_space
  (_)
)

; Indent the declarations in the block
(block
  .
  "{" @append_hardline @append_indent_start
  (declaration)
  "}" @prepend_hardline @prepend_indent_end @append_hardline
  .
)

; Always have semicolon after declarations
(
  (declaration) @append_delimiter
  (#delimiter! ";")
  (#not-match? @append_delimiter ";$")
)

; Appends hardline between declaration
(declaration
  ";" @append_hardline
)

; Add space between values after a property name
(declaration
  (property_name)
  ":" @append_space
  (_) @append_space
)

; Do not add a space between the last value and the ending semicolon
(declaration
  ";" @prepend_antispace
)

; Newline between selectors
(selectors
  "," @append_hardline
)

; Start block contents on new line
(block
  "{" @append_hardline
)
