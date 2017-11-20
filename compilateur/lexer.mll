{
  open Parser
  open Lexing
  open String

  let char_for_backslash = function
    | 'n' -> '\010'
    | 'r' -> '\013'
    | 'b' -> '\008'
    | 't' -> '\009'
    | c   -> c
}

rule lexer = parse
| [' ' '\t' '\n']   { lexer lexbuf }
| "/*"     { comments 0 lexbuf }
| "<-"     { ARROW }
| "<"      { LT }
| ">"      { GT }
| "="      { EQ }
| "!="     { NEQ }
| "+"      { PLUS }
| "-"      { MINUS }
| "|"      { OR }
| "&"      { AND }
| "^"      { XOR }
| "~"      { NOT }
| ";"      { SEQ }
| "!"      { REF }
| "skip"   { SKIP }
| "print"  { PRINT }
| "read"   { READ }
| "screen" { SCREEN }
| "if"     { IF }
| "then"   { THEN }
| "else"   { ELSE }
| "end"    { END }
| "while"  { WHILE }
| "do"     { DO }
| "done"   { DONE }
| ['_''a'-'z' 'A'-'Z'] ['a'-'z' 'A'-'Z' '0'-'9']* { IDENT (lexeme lexbuf) }
| ['0'-'9']+
| '0' ['x' 'X'] ['0'-'9' 'A'-'F' 'a'-'f']+
| '0' ['o' 'O'] ['0'-'7']+
| '0' ['b' 'B'] ['0'-'1']+ { INT (int_of_string (lexeme lexbuf)) }
| "'" [^ '\\' '\''] "'"    { INT (Char.code (lexeme_char lexbuf 1)) }
| "'" '\\' ['\\' '\'' 'n' 't' 'b' 'r'] "'"
    { INT (Char.code (char_for_backslash (lexeme_char lexbuf 2))) }
| eof { EOF }

and comments level = parse
| "*/" { if level = 0 then lexer lexbuf else comments (level - 1) lexbuf }
| "/*" { comments (level + 1) lexbuf }
| '"'[^'"']*'"' { comments level lexbuf }
| eof { EOF }
| _ { comments level lexbuf }
