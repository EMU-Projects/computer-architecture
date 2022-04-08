.data 0x10000000
# A[] is array with a trailing zero.
A:
.word 128 100 42 16 5 2 0 0
Count:
.word 0
Sum:
.word 0
Result:
.word 0
Remainder:
.word 0
EndofData:
.word -1
# End of data segment, code starts here from address 0x00400000
# Turn-off bare-machine, and turn-on pseudo-instruction options.
.text
.globl main
main:
# finding average of A[]
la $2,A # pseudo-instruction load-address A[.]
or $8,$0,$0 # 0 -> $8 , count
or $10,$0,0 # 0 -> $10, sum
slp:
lw $11,0($2) # A[i] -> $11
beq $11,$0,slx
add $10,$10,$11 # A[0]+...+A[i] -> $2
addi $8,$8,1 # ++count
addi $2,$2,4 # address of(A[i+1]) -> $2
j slp # loop until getting the zero
slx:
# save the count
sw $8,Count($0)
sw $10,Sum($0)
# divide $10 by $8, use count of repeating subtractions.
div $10,$8 # quotient is in LO, reminder is in HI
mflo $11 # move from LO to $destination
mfhi $10 # move from HI to $destination
sw $11,Result($0) # mean
sw $10,Remainder($0) # and this is the reminder of division
syscall # for the sake of SPIM add below one empty line