addi r1, r0, 3
sw r1, r0, 0
lw r1, r0, 1
addi r1, r1, 1
sw r1, r0, 0
lw r1, r0, 1
addi r1, r1, 1
sw r1, r0, 0
movi r1, 100
lw r2, r0, 1
add r1, r1, r2
sw r1, r0, 0
lw r1, r0, 1
movi r2, 100
add r1, r1, r2
sw r1, r0, 0
lw r1, r0, 1
lw r2, r0, 2
add r1, r1, r2
sw r1, r0, 0
addi r1, r0, -10
sw r1, r0, 0
lw r1, r0, 1
nand r1, r1, r1
addi r1, r1, 1
addi r1, r1, 1
sw r1, r0, 0
lw r1, r0, 1
addi r1, r1, -1
sw r1, r0, 0
movi r1, 100
lw r2, r0, 1
nand r2, r2, r2
addi r2, r2, 1
add r1, r1, r2
sw r1, r0, 0
lw r1, r0, 1
movi r2, -100
add r1, r1, r2
sw r1, r0, 0
lw r1, r0, 1
lw r2, r0, 2
nand r2, r2, r2
addi r2, r2, 1
add r1, r1, r2
sw r1, r0, 0
