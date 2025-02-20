.data
# ------------------------Write Your Code Here------------------------------
arr: .space 40 # Allocate space for the array (10 integers)
# ------------------------Write Your Code Here-------------------------------
newline:    .asciiz "\n"
result_true: .asciiz "True\n"
result_false: .asciiz "False\n"

.text
main:
    #first 2 elements, dont forget to store them in arr
    li $t0, 0 
    li $t1, 1
    # ------------------------Write Your Code Here------------------------------
   la $s0, arr
    sw $t0, 0($s0)     # arr[0]<-0
    sw $t1, 4($s0)    # arr[1]<-1 
    loop:
    li $t3 , 8    #int i = 2
    li $t4 , 40   #size =40
    conditionloop:
    beq $t3,$t4,endloop   #while(i<Size)
    bodyloop:
   add $t5 ,$t0,$t1
   move $t6,$t3
   add $t6,$t6,$s0 
   sw $t5,0($t6)  
   move $t0,$t1
   move $t1,$t5
   addi $t3,$t3,4    #i++
    j conditionloop
    endloop:
    
    # ------------------------Write Your Code Here-------------------------------
    la $s0, arr
    j check_array

check_array:
    # Check if the first element is 0 and the second one is 1
    lw $t1, 0($s0)   # Load the first element from the array pointed by $s0
    lw $t2, 4($s0)   # Load the second element from the array pointed by $s0

    li $t3, 0       # Constant value for comparison
    li $t4, 1     # Constant value for comparison

    # Check the conditions
    beq $t1, $t3, check_second_element
    j print_false

check_second_element:
    beq $t2, $t4, print_true
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
