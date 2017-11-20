addi r1, r0, 1
addi r2, r0, 0
if1begin: beq r1, r2, if1then
movi r1, if1else
jalr r0, r1
if1then: nop
movi r2, 0xFFE0
lw r1, r2, 0
sw r1, r0, 0
lw r1, r0, 0
movi r2, 0xFFEF
sw r1, r2, 0
movi r1 if1end
jalr r0, r1
if1else: nop
if1end: nop
addi r1, r0, 10
sw r1, r0, 1
while0begin: nop
lw r1, r0, 1
addi r2, r0, 0
beq r1, r2, while0toend
beq r0, r0, while0continue
while0toend: movi r1, while0end
jalr r0, r1
while0continue: nop
lw r1, r0, 1
movi r2, 0xFFEF
sw r1, r2, 0
lw r1, r0, 1
addi r1, r1, -1
sw r1, r0, 1
movi r1, while0begin
jalr r0, r1
while0end: nop
