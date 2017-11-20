type var =
  | Id of string
  | Ref of string

type value =
  | Var of var
  | Int of int

type expr =
  | Val of (value)
  | Add of (value * value)
  | Sub of (value * value)
  | Opp of (value)
  | Not of (value)
  | And of (value * value)
  | Or of (value * value)
  | Xor of (value * value)
  | Nand of (value * value)
  | Lt of (value * value)
  | Eq of (value * value)    
  | Neq of (value * value)    

type cmd =
  | Skip
  | Print of (expr)
  | Read of (var)
  | Screen of (expr * expr)
  | Aff of (var * expr)
  | Seq of (cmd * cmd)
  | If of (expr * cmd * cmd)
  | While of (expr * cmd)

let rec print_expr e = ()

let rec print_cmd = function
  | Skip -> Printf.printf "skip\n"
  | Print(e) -> Printf.printf "print\n"
  | Read(v) -> Printf.printf "read\n"
  | Screen(e) -> Printf.printf "screen\n"
  | Aff(Id(v),e) -> Printf.printf "%s <- " v; print_expr e; Printf.printf "\n"
  | Aff(Ref(v),e) -> Printf.printf "!%s <- " v; print_expr e; Printf.printf "\n"
  | Seq(c1, c2) -> print_cmd c1; print_cmd c2
  | If(e, c1, c2) ->
    Printf.printf "if "; print_expr e; Printf.printf " then\n";
    print_cmd c1;
    Printf.printf "else\n";
    print_cmd c2;
    Printf.printf "endif\n"
  | While(e, c) ->
    Printf.printf "while "; print_expr e; Printf.printf " do\n";
    print_cmd c;
    Printf.printf "enddo"
