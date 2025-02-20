.data
# ------------------------Write Your Code Here------------------------------

# ------------------------Write Your Code Here-----------------------------
newline:    .asciiz "\n"
result_true: .asciiz "True\n"
result_false: .asciiz "False\n"



.text
main:
    # You must use the values of these registers
    li $t0, 15 #A
    li $t1, 30 #B
    # ------------------------Write Your Code Here------------------------------
   #1.1
    add $s0,$t0,$t1 #C
   
    #1.2
    add $s4,$t0,200#A+200
    sub $s1,$s4,6 #D
    
    #1.3
    startloop:
    li  $s5,0     #i=0
    li  $s6,0
    loop_condition:
     bge $s5, $t1, endloop       # while(i >= B)
    loopbody:
    add $s6,$s6,$t1          #0+B+B+B.....B^2
    add $s5,$s5,1            #i++
    j loop_condition
    endloop:
    move $s2,$s6            #E=B^2 
    
    #1.4
    li $s4 , 0
    li $s5 , 0
    li $s6 , 0
    add $s4,$s0,$s1    #C+D
    add $s5,$s4,$s2    #C+D+E
    sub $s3,$s5,2      #C+D+E-2
    # ------------------------Write Your Code Here-------------------------------
    
    j checkQs1Partialy


checkQs1Partialy:
	li $t5, 45
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
