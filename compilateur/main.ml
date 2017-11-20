open Term
  
let parse lex =
  try Parser.cmd Lexer.lexer lex
  with e -> failwith (Printf.sprintf "Error: %s near '%s' (position %d)."
			(Printexc.to_string e)
			(Lexing.lexeme lex)
			(Lexing.lexeme_start lex))
    
let cmd_of_channel c = parse (Lexing.from_channel c)

let display c =
  begin
    print_endline "Parsing ok.";
    print_endline "------------------------";
    print_cmd c;
    print_endline "------------------------";
    print_newline ()
  end
    
let list_var c =
  let rec list_var_value l = function
    | Var(Id(s)) -> s::l
    | Var(Ref(s)) -> s::l
    | Int i -> l in
  let rec list_var_expr l = function
    | Val(v)      -> list_var_value l v
    | Opp(v)      -> list_var_value l v
    | Add(e1,e2)  -> list_var_value (list_var_value l e1) e2
    | Sub(e1,e2)  -> list_var_value (list_var_value l e1) e2
    | Not(v)      -> list_var_value l v
    | And(e1,e2)  -> list_var_value (list_var_value l e1) e2
    | Or(e1,e2)   -> list_var_value (list_var_value l e1) e2
    | Nand(e1,e2) -> list_var_value (list_var_value l e1) e2
    | Xor(e1,e2)  -> list_var_value (list_var_value l e1) e2
    | Lt(e1, e2)  -> list_var_value (list_var_value l e1) e2
    | Neq(e1, e2) -> list_var_value (list_var_value l e1) e2
    | Eq(e1, e2)  -> list_var_value (list_var_value l e1) e2 in
  let rec list_var_cmd l = function
    | Skip           -> l
    | Print(e)       -> list_var_expr l e
    | Read(v)        -> list_var_value l (Var v)
    | Screen(e1, e2) -> list_var_expr (list_var_expr l e1) e2
    | Aff(v,e)       -> list_var_value (list_var_expr l e) (Var v)
    | Seq(c1, c2)    -> list_var_cmd (list_var_cmd l c1) c2
    | If(e, c1, c2)  -> list_var_cmd (list_var_cmd (list_var_expr l e) c1) c2
    | While(e, c)    -> list_var_cmd (list_var_expr l e) c in
  let rec doublons = function
    | [] -> []
    | [a] -> [a]
    | a::b::l -> if a = b then (doublons (b::l)) else a::(doublons (b::l)) in
  let l = doublons (List.sort String.compare (list_var_cmd [] c)) in
  let _, lst = List.fold_left (fun (i,l) s -> (i+1, (s,i)::l)) (0, []) l in lst

let tty_adress = "0xFFEF"
let keyboard_adress = "0xFFE0"
let screen_adress = "0xFFF0"

let compile vars ex =
  let seed = ref 0 in
  let rec compile_expr dest l = function
    | Val(Int i) when -64 <= i && i <= 63 ->
      (Printf.sprintf "addi %s, r0, %d" dest i)::l
    | Val(Int i) -> 
      (Printf.sprintf "movi %s, %d" dest i)::l
    | Val(Var(Id s)) ->
      (Printf.sprintf "lw %s, r0, %d" dest (List.assoc s vars))::l
    | Val(Var(Ref s)) ->
      (Printf.sprintf "lw %s, r0, %d" dest (List.assoc s vars))
      ::(Printf.sprintf "lw %s, %s, 0" dest dest)
      ::l
    | Add(Int i1, Int i2) ->
      compile_expr dest l (Val(Int(i1+i2)))
    | Add(v, Int i)
    | Add(Int i, v) when (-64 <= i && i <= 63) ->
      compile_expr dest ((Printf.sprintf "addi %s, %s, %d" dest dest i)::l) (Val(v))
    | Add(v1, v2) -> 
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "add %s, r1, r2" dest)::l)
	   (Val(v2)))
	(Val(v1))
    | Opp(Int i) ->
      compile_expr dest l (Val(Int(-i)))
    | Opp(v) ->
      compile_expr dest
	((Printf.sprintf "nand %s, %s, %s" dest dest dest)
	 ::(Printf.sprintf "addi %s, %s, 1" dest dest)
	 ::l)
	(Val(v))
    | Sub(Int i1, Int i2) ->
      compile_expr dest l (Val(Int(i1-i2)))
    | Sub(v, Int i) ->
      compile_expr dest l (Add(v, Int(-i)))
    | Sub(Int i, v) when (-64 <= i && i <= 63) ->
      compile_expr "r1"
	((Printf.sprintf "addi %s, r1, %d" dest i)::l) (Opp(v))
    | Sub(v1, v2) ->
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "add %s, r1, r2" dest)::l)
	   (Opp(v2)))
	(Val(v1))
    | Not(v) ->
      compile_expr dest	((Printf.sprintf "nand %s, %s, %s" dest dest dest)::l) (Val(v))
    | And(v1, v2) ->
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "nand %s, r1, r2" dest)
	    ::(Printf.sprintf "nand %s, %s, %s" dest dest dest)
	    ::l)
	   (Val(v2)))
	(Val(v1))
    | Or(v1, v2) ->
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "nand %s, r1, r2" dest) ::l)
	   (Not(v2)))
	(Not(v1))
    | Xor(v1, v2) ->
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "nand r3, r1, r2")
	    ::(Printf.sprintf "nand r1, r1, r3")
	    ::(Printf.sprintf "nand r2, r2, r3")
	    ::(Printf.sprintf "nand %s, r1, r2" dest)
	    ::l)
	   (Val(v2)))
	(Val(v1))
    | Nand(v1, v2) ->
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "nand %s, r1, r2" dest)::l)
	   (Val(v2)))
	(Val(v1))
    | Lt(v1, v2) -> failwith "Error, comparison test found"
    | Eq(v1, v2) -> failwith "Error, equality test found"
    | Neq(v1, v2) -> failwith "Error, equality test found" in
  let rec compile_cmd l = function
    | Skip -> l
    | Print(e) ->
      compile_expr "r1"
	((Printf.sprintf "movi r2, %s" tty_adress)
	 ::(Printf.sprintf "sw r1, r2, 0")
	 ::l)
	e
    | Read(Id(s)) ->
      (Printf.sprintf "movi r2, %s" keyboard_adress)
      ::(Printf.sprintf "lw r1, r2, 0")
      ::(Printf.sprintf "sw r1, r0, %d" (List.assoc s vars))
      ::l
    | Read(Ref(s)) ->
      (Printf.sprintf "lw r3, r0, %d" (List.assoc s vars))
      ::(Printf.sprintf "movi r2, %s" keyboard_adress)
      ::(Printf.sprintf "lw r1, r2, 0")
      ::(Printf.sprintf "sw r1, r3, 0")
      ::l
    | Screen(Val(Int(i)), e) ->
      if i < 0 || i >= 16 then failwith "Out of the screen !";
      compile_expr "r1"
	((Printf.sprintf "movi r2, %s" screen_adress)
	 ::(Printf.sprintf "sw r1, r2, %d" i)
	 ::l)
	e
    | Screen(e1, e2) ->
      compile_expr "r1"
	(compile_expr "r4"
	   ((Printf.sprintf "movi r2, %s" screen_adress)
	    ::(Printf.sprintf "add r2, r2, r1")
	    ::(Printf.sprintf "sw r4, r2, 0")
	    ::l)
	   e2)
	e1
    | Aff(Id(s),e) ->
      compile_expr "r1"
	((Printf.sprintf "sw r1, r0, %d" (List.assoc s vars))::l)
	e
    | Aff(Ref(s),e) ->
      compile_expr "r1"
	((Printf.sprintf "lw r2, r0, %d" (List.assoc s vars))
	 ::(Printf.sprintf "sw r1, r2, 0")::l)
	e
    | Seq(c1, c2) ->
      compile_cmd (compile_cmd l c2) c1
    | If(Eq(v1, v2), c1, c2) -> let s = !seed in incr seed;
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "if%dbegin: beq r1, r2, if%dthen" s s)
	    ::(Printf.sprintf "movi r1, if%delse" s)
	    ::(Printf.sprintf "jalr r0, r1")
	    ::(Printf.sprintf "if%dthen: nop" s)
	    ::(compile_cmd
		 ((Printf.sprintf "movi r1 if%dend" s)
		  ::(Printf.sprintf "jalr r0, r1")
		  ::(Printf.sprintf "if%delse: nop" s)
		  ::(compile_cmd
		       ((Printf.sprintf "if%dend: nop" s)
			::l)
		       c2))
		 c1))
	   (Val(v2)))
	(Val(v1))
    | If(Neq(v1, v2), c1, c2) -> let s = !seed in incr seed;
      compile_expr "r1"
	(compile_expr "r2"
	   ((Printf.sprintf "if%dbegin: beq r1, r2, if%delse" s s)
	    ::(Printf.sprintf "movi r1, if%dthen" s)
	    ::(Printf.sprintf "jalr r0, r1")
	    ::(Printf.sprintf "if%delse: nop" s)
	    ::(compile_cmd
		 ((Printf.sprintf "movi r1 if%dend" s)
		  ::(Printf.sprintf "jalr r0, r1")
		  ::(Printf.sprintf "if%dthen: nop" s)
		  ::(compile_cmd
		       ((Printf.sprintf "if%dend: nop" s)
			::l)
		       c1))
		 c2))
	   (Val(v2)))
	(Val(v1))
    | If(e, c1, c2) ->
      let s = !seed in incr seed;
      compile_expr "r1"
	((Printf.sprintf "if%dbegin: beq r1, r0, if%delse" s s)
	 ::(Printf.sprintf "movi r1, if%dthen" s)
	 ::(Printf.sprintf "jalr r0, r1")
	 ::(Printf.sprintf "if%delse: nop" s)
	 ::(compile_cmd
	      ((Printf.sprintf "movi r1 if%dend" s)
	       ::(Printf.sprintf "jalr r0, r1")
	       ::(Printf.sprintf "if%dthen: nop" s)
	       ::(compile_cmd
		    ((Printf.sprintf "if%dend: nop" s)
		     ::l)
		    c1))
	      c2))
	e
    | While(Eq(v1, v2), c) ->
      let s = !seed in incr seed;
      (Printf.sprintf "while%dbegin: nop" s)
      ::(compile_expr "r1"
	   (compile_expr "r2"
	      ((Printf.sprintf "beq r1, r2, while%dcontinue" s)
	       ::(Printf.sprintf "movi r1, while%dend" s)
	       ::(Printf.sprintf "jalr r0, r1")
	       ::(Printf.sprintf "while%dcontinue: nop" s)
	       ::(compile_cmd
		    ((Printf.sprintf "movi r1, while%dbegin" s)
		     ::(Printf.sprintf "jalr r0, r1")
		     ::(Printf.sprintf "while%dend: nop" s)
		     ::l)
		    c))
	   (Val(v2)))
	(Val(v1)))
    | While(Neq(v1, v2), c) ->
      let s = !seed in incr seed;
      (Printf.sprintf "while%dbegin: nop" s)
      ::(compile_expr "r1"
	   (compile_expr "r2"
	      ((Printf.sprintf "beq r1, r2, while%dtoend" s)
	       ::(Printf.sprintf "beq r0, r0, while%dcontinue" s)
	       ::(Printf.sprintf "while%dtoend: movi r1, while%dend" s s)
	       ::(Printf.sprintf "jalr r0, r1")
	       ::(Printf.sprintf "while%dcontinue: nop" s)
	       ::(compile_cmd
		    ((Printf.sprintf "movi r1, while%dbegin" s)
		     ::(Printf.sprintf "jalr r0, r1")
		     ::(Printf.sprintf "while%dend: nop" s)
		     ::l)
		    c))
	   (Val(v2)))
	(Val(v1)))
    | While(e, c) -> let s = !seed in incr seed;
      (Printf.sprintf "while%dbegin: nop" s)
      ::(compile_expr "r1"
	   ((Printf.sprintf "beq r1, r0, while%dtoend" s)
	    ::(Printf.sprintf "beq r0, r0, while%dcontinue" s)
	    ::(Printf.sprintf "while%dtoend: movi r1, while%dend" s s)
	    ::(Printf.sprintf "jalr r0, r1")
	    ::(Printf.sprintf "while%dcontinue: nop" s)
	    ::(compile_cmd
		 ((Printf.sprintf "movi r1, while%dbegin" s)
		  ::(Printf.sprintf "jalr r0, r1")
		  ::(Printf.sprintf "while%dend: nop" s)
		  ::l)
		 c))
	   e) in
  compile_cmd [] ex

let main () =
  if Array.length Sys.argv < 2 then
    begin
      print_endline "No file provided !";
      Printf.printf "usage: %s foo.imp\n" Sys.argv.(0)
    end
  else
    try
      let c = cmd_of_channel (open_in Sys.argv.(1)) in
      (*display c;*)
      let vars = list_var c in
      (*List.iter (fun (x,i) -> Printf.printf "%d %s\n" i x) vars;*)
      if List.length vars > 63 then failwith "More than 63 variables...";
      List.iter print_endline (compile vars c);
      (* todo *)
      flush stdout
    with
      | Invalid_argument s -> Printf.printf "Error: '%s'\n" s
      | End_of_file -> Printf.printf "Unexpected end of input\n"
;;

main ()
