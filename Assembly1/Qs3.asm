.data
# ------------------------Write Your Code Here------------------------------
arr1: .space 40 # Allocate space for the array (10 integers)
arr: .word -23, 2354, 34, 10, -3553, 4234, 81, 90, 634, -27 # Allocate space for the array (10 integers)
# ------------------------Write Your Code Here-----------------------------
newline:    .asciiz "\n"
result_true: .asciiz "True\n"
result_false: .asciiz "False\n"



.text
main:
    # ------------------------Write Your Code Here------------------------------
 li $t0,0   #i=0
    li $t1,40  #size
    la $s4,arr
    li $t6,0   #sum
    lw $t2,0($s4)   #to_find_max
    lw $t3,0($s4)   #to_find_min
    loop_condition:
    beq $t0,$t1,endloop   #while i<size
    bodyloop:
    lw $t4,0($s4)
    lw $t7,0($s4)
    add $t6,$t6,$t7
    bgt $t4,$t2,max_update
    blt $t4,$t3,min_update
    inc_loop:
    addi $s4,$s4,4
    addi $t0,$t0,4
    j loop_condition
    
    max_update:
    move $t2,$t4
    j inc_loop
    min_update:
    move $t3,$t4
    j inc_loop
    
    
    endloop:
    move $s0,$t2
    move $s1,$t3
    move $s2,$t6
    
    li $t5,10
    div $s2,$t5
    mflo $s3  
    
    # ------------------------Write Your Code Here-------------------------------
    
    j checkQs3Partialy


checkQs3Partialy:
	li $t5, 4234
	beq $s0, $t5, print_true
	j print_false

print_true:
    # Print True
    li $v0, 4      # System call for print_str
    la $a0, result_true
    syscall
    j end_program

print_false:
    # Print False
    li $v0, 4      # System call for print_str
    la $a0, result_false
    syscall

end_program:
    # Exit the program
    li $v0, 10
    syscall
