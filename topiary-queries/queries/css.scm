;; Sometimes we want to indicate that certain parts of our source text should
;; not be formatted, but taken as is. We use the leaf capture name to inform the
;; tool of this.
(integer_value) @leaf
(plain_value) @leaf

; Append space after colons
":" @append_space

(rule_set) @allow_blank_line_before
(rule_set) @prepend_hardline

; Allow blank lines before any declaration in a block except the first one
(block . (declaration) (declaration) @allow_blank_line_before)

[(selectors)] @append_space


(block
  .
  "{" @append_hardline @append_indent_start
  (declaration)
  "}" @prepend_hardline @prepend_indent_end
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

