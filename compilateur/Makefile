EXE=imp

all: $(EXE)

parser.ml parser.mli: parser.mly
	ocamlyacc -v parser.mly

lexer.ml: lexer.mll
	ocamllex lexer.mll

parser.cmi: parser.mli
	ocamlc -c parser.mli

lexer.cmo: lexer.ml parser.cmo
	ocamlc -c lexer.ml

parser.cmo: parser.ml parser.cmi term.cmo
	ocamlc -c parser.ml

term.cmo: term.ml
	ocamlc -c term.ml

main.cmo: main.ml
	ocamlc -c main.ml

$(EXE): term.cmo parser.cmo lexer.cmo main.cmo
	ocamlc -o $(EXE) term.cmo parser.cmo lexer.cmo main.cmo

clean:
	rm -f *.cmo *.cmi parser.ml lexer.ml parser.mli lexer.mli $(EXE) parser.output *~
