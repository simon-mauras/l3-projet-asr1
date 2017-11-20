movi r1, 200
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 2080
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 1088
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 4064
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 7088
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 16376
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 12264
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 10280
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
movi r1, 1728
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
lw r2, r0, 8
sw r1, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
addi r1, r0, 0
sw r1, r0, 2
movi r1, 200
sw r1, r0, 8
movi r1, 100
sw r1, r0, 9
addi r1, r0, 1
sw r1, r0, 5
while11begin: nop
lw r1, r0, 2
addi r2, r0, 16
beq r1, r2, while11toend
beq r0, r0, while11continue
while11toend: movi r1, while11end
jalr r0, r1
while11continue: nop
lw r1, r0, 2
lw r4, r0, 8
lw r4, r4, 0
movi r2, 0xFFF0
add r2, r2, r1
sw r4, r2, 0
lw r1, r0, 8
addi r1, r1, 1
sw r1, r0, 8
lw r1, r0, 5
lw r2, r0, 9
sw r1, r2, 0
lw r1, r0, 5
lw r2, r0, 5
add r1, r1, r2
sw r1, r0, 5
lw r1, r0, 9
addi r1, r1, 1
sw r1, r0, 9
lw r1, r0, 2
addi r1, r1, 1
sw r1, r0, 2
movi r1, while11begin
jalr r0, r1
while11end: nop
addi r1, r0, 8
sw r1, r0, 6
addi r1, r0, 15
sw r1, r0, 7
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
sw r1, r0, 10
lw r1, r0, 10
nand r1, r1, r1
lw r2, r0, 8
lw r2, r2, 0
nand r2, r2, r2
nand r1, r1, r2
sw r1, r0, 9
lw r1, r0, 7
lw r4, r0, 9
lw r4, r4, 0
movi r2, 0xFFF0
add r2, r2, r1
sw r4, r2, 0
movi r2, 0xFFE0
lw r1, r2, 0
sw r1, r0, 1
lw r1, r0, 1
movi r2, 113
if9begin: beq r1, r2, if9then
movi r1, if9else
jalr r0, r1
if9then: nop
lw r1, r0, 6
addi r2, r0, 0
if10begin: beq r1, r2, if10else
movi r1, if10then
jalr r0, r1
if10else: nop
movi r1 if10end
jalr r0, r1
if10then: nop
lw r1, r0, 6
addi r1, r1, -1
sw r1, r0, 6
if10end: nop
movi r1 if9end
jalr r0, r1
if9else: nop
if9end: nop
lw r1, r0, 1
movi r2, 100
if7begin: beq r1, r2, if7then
movi r1, if7else
jalr r0, r1
if7then: nop
lw r1, r0, 6
addi r2, r0, 15
if8begin: beq r1, r2, if8else
movi r1, if8then
jalr r0, r1
if8else: nop
movi r1 if8end
jalr r0, r1
if8then: nop
lw r1, r0, 6
addi r1, r1, 1
sw r1, r0, 6
if8end: nop
movi r1 if7end
jalr r0, r1
if7else: nop
if7end: nop
lw r1, r0, 1
movi r2, 122
if5begin: beq r1, r2, if5then
movi r1, if5else
jalr r0, r1
if5then: nop
lw r1, r0, 6
addi r2, r0, 0
if6begin: beq r1, r2, if6else
movi r1, if6then
jalr r0, r1
if6else: nop
movi r1 if6end
jalr r0, r1
if6then: nop
lw r1, r0, 7
addi r1, r1, -1
sw r1, r0, 7
if6end: nop
movi r1 if5end
jalr r0, r1
if5else: nop
if5end: nop
lw r1, r0, 1
movi r2, 115
if3begin: beq r1, r2, if3then
movi r1, if3else
jalr r0, r1
if3then: nop
lw r1, r0, 7
addi r2, r0, 15
if4begin: beq r1, r2, if4else
movi r1, if4then
jalr r0, r1
if4else: nop
movi r1 if4end
jalr r0, r1
if4then: nop
lw r1, r0, 7
addi r1, r1, 1
sw r1, r0, 7
if4end: nop
movi r1 if3end
jalr r0, r1
if3else: nop
if3end: nop
lw r1, r0, 1
addi r2, r0, 32
if1begin: beq r1, r2, if1then
movi r1, if1else
jalr r0, r1
if1then: nop
lw r1, r0, 7
sw r1, r0, 3
lw r1, r0, 9
lw r1, r1, 0
sw r1, r0, 11
movi r1, 200
lw r2, r0, 3
add r1, r1, r2
sw r1, r0, 8
lw r1, r0, 8
lw r1, r1, 0
nand r1, r1, r1
lw r2, r0, 11
nand r2, r2, r2
nand r1, r1, r2
sw r1, r0, 0
lw r1, r0, 3
lw r4, r0, 0
movi r2, 0xFFF0
add r2, r2, r1
sw r4, r2, 0
lw r1, r0, 8
lw r1, r1, 0
lw r2, r0, 4
nand r1, r1, r2
nand r1, r1, r1
if2begin: beq r1, r0, if2else
movi r1, if2then
jalr r0, r1
if2else: nop
movi r1 if2end
jalr r0, r1
if2then: nop
lw r1, r0, 8
lw r1, r1, 0
lw r2, r0, 4
nand r3, r1, r2
nand r1, r1, r3
nand r2, r2, r3
nand r1, r1, r2
lw r2, r0, 8
sw r1, r2, 0
addi r1, r0, 0
sw r1, r0, 4
if2end: nop
lw r1, r0, 3
lw r4, r0, 8
lw r4, r4, 0
movi r2, 0xFFF0
add r2, r2, r1
sw r4, r2, 0
movi r1 if1end
jalr r0, r1
if1else: nop
if1end: nop
movi r1, while0begin
jalr r0, r1
while0end: nop
