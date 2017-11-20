%{ open Term %}

%token READ PRINT SCREEN ARROW REF
%token SEQ SKIP
%token IF THEN ELSE END WHILE DO DONE
%token EOF
%token LT GT EQ NEQ PLUS MINUS OR AND NOT XOR NAND
%token <int> INT
%token <string> IDENT

%left SEQ
%nonassoc IF THEN ELSE WHILE DO
%nonassoc LBRACE RBRACE IDENT INT BOOL 

%start cmd
%type <Term.cmd> cmd
%%

var:
  | IDENT                          { Id $1 }
  | REF IDENT                      { Ref $2 }
 
value: 
  | INT                            { Int $1 }
  | var                            { Var $1 }

expr:
  | value                          { Val $1 }
  | value PLUS value               { Add ($1, $3) }
  | value MINUS value              { Sub ($1, $3) }
  | MINUS value                    { Opp ($2) }
  | value AND value                { And ($1, $3) }
  | value OR value                 { Or ($1, $3) }
  | value XOR value                { Xor ($1, $3) }
  | NOT value                      { Not ($2) }
  | value EQ value                 { Eq ($1, $3) }
  | value NEQ value                { Neq ($1, $3) }
  | value LT value                 { Lt ($1, $3) }
  | value GT value                 { Lt ($3, $1) }

cmd:
  | SKIP                           { Skip }
  | PRINT expr                     { Print $2 }
  | READ var                       { Read $2 }
  | SCREEN expr ARROW expr         { Screen ($2, $4) }
  | var ARROW expr                 { Aff ($1, $3) }
  | cmd SEQ cmd                    { Seq ($1, $3) }
  | cmd SEQ                        { $1 }
  | IF expr THEN cmd ELSE cmd END  { If ($2, $4, $6) }
  | IF expr THEN cmd END           { If ($2, $4, Skip) }
  | WHILE expr DO cmd DONE         { While ($2, $4) }

%%
