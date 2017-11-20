SRC = $(wildcard *.imp)
BINS = $(SRC:.imp=.bin)
ASMS=$(SRC:.imp=.asm)

all: $(BINS)

asm: $(ASMS)

%.bin: %.asm
	../../risc16-assembler ./$< ./$@

%.asm: %.imp
	../imp ./$< > ./$@

clean:
	rm -f *.asm *.bin
