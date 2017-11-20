while0begin: nop
addi r1, r0, 2
addi r2, r0, 2
beq r1, r2, while0continue
movi r1, while0end
jalr r0, r1
while0continue: nop
movi r1, 122
sw r1, r0, 0
while2begin: nop
lw r1, r0, 0
movi r2, 96
beq r1, r2, while2toend
beq r0, r0, while2continue
while2toend: movi r1, while2end
jalr r0, r1
while2continue: nop
lw r1, r0, 0
movi r2, 0xFFEF
sw r1, r2, 0
lw r1, r0, 0
addi r1, r1, -1
sw r1, r0, 0
movi r1, while2begin
jalr r0, r1
while2end: nop
addi r1, r0, 0
sw r1, r0, 0
while1begin: nop
lw r1, r0, 0
addi r2, r0, 0
beq r1, r2, while1continue
movi r1, while1end
jalr r0, r1
while1continue: nop
movi r2, 0xFFE0
lw r1, r2, 0
sw r1, r0, 0
movi r1, while1begin
jalr r0, r1
while1end: nop
addi r1, r0, 10
movi r2, 0xFFEF
sw r1, r2, 0
movi r1, 111
movi r2, 0xFFEF
sw r1, r2, 0
movi r1, 107
movi r2, 0xFFEF
sw r1, r2, 0
addi r1, r0, 10
movi r2, 0xFFEF
sw r1, r2, 0
movi r1, while0begin
jalr r0, r1
while0end: nop
