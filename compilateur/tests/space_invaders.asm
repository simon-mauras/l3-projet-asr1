movi r1, 200
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 2080
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 1088
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 4064
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 7088
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 16376
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 12264
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 10280
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
movi r1, 1728
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
lw r2, r0, 7
sw r1, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
addi r1, r0, 0
sw r1, r0, 2
movi r1, 200
sw r1, r0, 7
movi r1, 100
sw r1, r0, 8
addi r1, r0, 1
sw r1, r0, 5
while8begin: nop
lw r1, r0, 2
addi r2, r0, 16
beq r1, r2, while8toend
beq r0, r0, while8continue
while8toend: movi r1, while8end
jalr r0, r1
while8continue: nop
lw r1, r0, 2
lw r4, r0, 7
lw r4, r4, 0
movi r2, 0xFFF0
add r2, r2, r1
sw r4, r2, 0
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
lw r1, r0, 5
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 5
lw r2, r0, 5
add r1, r1, r2
sw r1, r0, 5
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
lw r1, r0, 2
addi r1, r1, 1
sw r1, r0, 2
movi r1, while8begin
jalr r0, r1
while8end: nop
addi r1, r0, 8
sw r1, r0, 6
movi r1, 71
movi r2, 0xFFEF
sw r1, r2, 0
movi r1, 111
movi r2, 0xFFEF
sw r1, r2, 0
addi r1, r0, 32
movi r2, 0xFFEF
sw r1, r2, 0
addi r1, r0, 33
movi r2, 0xFFEF
sw r1, r2, 0
while0begin: nop
addi r1, r0, 1
beq r1, r0, while0toend
beq r0, r0, while0continue
while0toend: movi r1, while0end
jalr r0, r1
while0continue: nop
movi r1, 100
lw r2, r0, 6
add r1, r1, r2
sw r1, r0, 8
lw r1, r0, 8
lw r1, r1, 0
movi r2, 0xFFF0
sw r1, r2, 15
movi r2, 0xFFE0
lw r1, r2, 0
sw r1, r0, 1
lw r1, r0, 1
movi r2, 97
if6begin: beq r1, r2, if6then
movi r1, if6else
jalr r0, r1
if6then: nop
lw r1, r0, 6
addi r2, r0, 0
if7begin: beq r1, r2, if7else
movi r1, if7then
jalr r0, r1
if7else: nop
movi r1 if7end
jalr r0, r1
if7then: nop
lw r1, r0, 6
addi r1, r1, -1
sw r1, r0, 6
if7end: nop
movi r1 if6end
jalr r0, r1
if6else: nop
if6end: nop
lw r1, r0, 1
movi r2, 98
if4begin: beq r1, r2, if4then
movi r1, if4else
jalr r0, r1
if4then: nop
lw r1, r0, 6
addi r2, r0, 15
if5begin: beq r1, r2, if5else
movi r1, if5then
jalr r0, r1
if5else: nop
movi r1 if5end
jalr r0, r1
if5then: nop
lw r1, r0, 6
addi r1, r1, 1
sw r1, r0, 6
if5end: nop
movi r1 if4end
jalr r0, r1
if4else: nop
if4end: nop
lw r1, r0, 1
addi r2, r0, 32
if1begin: beq r1, r2, if1then
movi r1, if1else
jalr r0, r1
if1then: nop
addi r1, r0, 15
sw r1, r0, 3
lw r1, r0, 8
lw r1, r1, 0
sw r1, r0, 4
while2begin: nop
lw r1, r0, 3
addi r2, r0, 0
beq r1, r2, while2toend
beq r0, r0, while2continue
while2toend: movi r1, while2end
jalr r0, r1
while2continue: nop
lw r1, r0, 3
addi r1, r1, -1
sw r1, r0, 3
movi r1, 200
lw r2, r0, 3
add r1, r1, r2
sw r1, r0, 7
lw r1, r0, 7
lw r1, r1, 0
nand r1, r1, r1
lw r2, r0, 4
nand r2, r2, r2
nand r1, r1, r2
sw r1, r0, 0
lw r1, r0, 3
lw r4, r0, 0
movi r2, 0xFFF0
add r2, r2, r1
sw r4, r2, 0
lw r1, r0, 7
lw r1, r1, 0
lw r2, r0, 4
nand r1, r1, r2
nand r1, r1, r1
if3begin: beq r1, r0, if3else
movi r1, if3then
jalr r0, r1
if3else: nop
movi r1 if3end
jalr r0, r1
if3then: nop
lw r1, r0, 7
lw r1, r1, 0
lw r2, r0, 4
nand r3, r1, r2
nand r1, r1, r3
nand r2, r2, r3
nand r1, r1, r2
lw r2, r0, 7
sw r1, r2, 0
addi r1, r0, 0
sw r1, r0, 4
if3end: nop
lw r1, r0, 3
lw r4, r0, 7
lw r4, r4, 0
movi r2, 0xFFF0
add r2, r2, r1
sw r4, r2, 0
movi r1, while2begin
jalr r0, r1
while2end: nop
movi r1 if1end
jalr r0, r1
if1else: nop
if1end: nop
movi r1, while0begin
jalr r0, r1
while0end: nop
