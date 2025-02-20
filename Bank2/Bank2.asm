.data
    buffer:         .space 104      
    CustomersDataBase: 	.space 40
    customer_count: .word 0         
    
    # Messages
    success:		.asciiz "Success: "
    enter_id_msg:               .asciiz "Enter customer ID: "
    enter_name_msg:             .asciiz "Enter customer name: "
    enter_balance_msg:          .asciiz "Enter customer balance: "
    enter_new_balance_msg:      .asciiz "Enter new balance: "
    inputmsg:    .asciiz "Enter your choice (1-4):"
    exitmsg:   .asciiz "Exiting program"
    id_exists_error_msg:        .asciiz "Error: Customer "
    id_exists_error_msg1:      .asciiz " already exists\n"
    id_not_exists_error_msg:    .asciiz "Error: Customer "
    id_not_exists_error_msg1:    .asciiz " doesn't exist\n"
    comma_msg: .asciiz ", "
    
    success_addcus_message: .asciiz "Success: Customer "
    success_addcus_message1: .asciiz " was added\n"
    

    invalid_balance_msg:        .asciiz "Error: The inputted balance isn't valid\n"
    main_menu:                  .asciiz "\n1)add_customer\n2)display_customer\n3)update_balance\n4)exit_program\n"
    invalid_choice_msg:         .asciiz "Invalid choice. Please enter a number between 1 and 4.\n"

.text
   la $s5,CustomersDataBase
main:
    li $v0, 4
    la $a0, main_menu
    syscall
   
    li $v0, 4
    la $a0, inputmsg 
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0

   
    beq $t0, 1, add_customer
    beq $t0, 2, display_customer
    beq $t0, 3, update_balance
    beq $t0, 4, exit_program
    blt $t0, 1, invalid_choice
    bgt $t0, 4, invalid_choice
    
invalid_choice:
    li $v0,4
    la $a0,invalid_choice_msg
    syscall
    j main
    
add_customer:
    
    li $v0, 4
    la $a0, enter_id_msg
    syscall

    li $v0, 5
    syscall
    move $a1, $v0   
  
    sub $sp, $sp, 4
    sw $a1, 0($sp)
    
    li $v0, 4
    la $a0, enter_name_msg
    syscall
   
    li $v0, 8
    la $a0, buffer
    li $a1, 100
    syscall
    lw $a1, 0($sp)
    addi $sp, $sp, 4
        
    sub $sp, $sp, 4
    sw $a0, 0($sp)
    
    li $v0, 4
    la $a0, enter_balance_msg
    syscall
    
    li $v0, 5
    syscall
    move $a2, $v0 
     
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    
    j add_customer_to_database
    add_count:
    
    lw $t0, customer_count
    addi $t0, $t0, 1
    sw $t0, customer_count		
    addi $s5, $s5, 4

    j successaddcus
    

add_customer_to_database:
        sub $sp, $sp, 8
	sw $ra, 0($sp)
	sw $a1, 4($sp)
	
	jal id_isLegal
    
       bne $v0,0, id_exists_error
       jal balance_isLegal
       beqz $v0,invalid_balance
       
	li $v0, 9
	li $a0, 108   
	syscall 
	move $s1, $v0
	
	sw $a1, 0($s1)
	sw $a2, 104($s1)	
	la $a1, 4($s1)    
	la $a0, buffer    
	j copy_string
	addCus:
	sw $s1, 0($s5)
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	add $sp, $sp, 8
        j add_count
invalid_balance:
li $v0,4
la $a0,invalid_balance_msg
syscall 
j main    
balance_isLegal:
        li $v0, 1
	bge $a2, 99999, can_not
	bge $a2, 0, done	
	can_not:
	li $v0, 0
	
	done: 
	jr $ra
successaddcus:
li $v0,4
la $a0,success_addcus_message
syscall 
li $v0,1

move $a0, $a1
syscall
li $v0,4
la $a0,success_addcus_message1
syscall 
     
j main    

copy_string:
    li $t0, 0  

copy_loop:

    	lb $t1, 0($a0)      
    	beq $t1, 10, copy_done  

    	sb $t1, 0($a1)       
    	addi $a1, $a1, 1     
    	addi $a0, $a0, 1     
    	j copy_loop

copy_done:
    j addCus    


id_exists_error:
    li $v0, 4
    la $a0, id_exists_error_msg
    syscall
    li $v0,1
    
    move $a0,$a1
    syscall
    li $v0, 4
    la $a0, id_exists_error_msg1
    syscall
    j main
id_isLegal:

	li $v0, 0
	la $t0,CustomersDataBase
	lw $t1, customer_count
	li $t2, 0
	id_loop:        
	beq $t2, $t1, found
	lw $t3, 0($t0)
	lw $t4, 0($t3)
	bne $a1, $t4, notFound
	li $v0, 1
	move $v1, $t3		
	move $a3, $t0           
	j found
	
	notFound:
	addi $t0, $t0, 4
	addi $t2, $t2, 1
	
	j id_loop
	found:

	jr $ra
    

display_customer:
        li $v0, 4
	la $a0, enter_id_msg
	syscall 
	li $v0, 5
	syscall 
	move $a1, $v0
    jal id_isLegal 

    bne $v0, 1, id_not_exists
    
    move $a3, $v1
    jal display_customer_help
    j main
display_customer_help: 
	
	li $v0, 4
	la $a0, success
	syscall 
	li $v0, 1
	lw $a0, 0($a3)
	syscall 
	
	li $v0, 4
	la $a0, comma_msg
	syscall 
	
	li $v0, 4
	la $a0, 4($a3)
	syscall 
	
	li $v0, 4
	la $a0, comma_msg
	syscall 
	
	li $v0, 1
	lw $a0, 104($a3)
	syscall
			
        jr $ra


id_not_exists:
    li $v0, 4
    la $a0, id_not_exists_error_msg
    syscall
    li $v0,1 
    
    move $a0,$a1
    syscall
     li $v0, 4
    la $a0, id_not_exists_error_msg1
    syscall

    j main

update_balance:

    li $v0, 4
    la $a0, enter_id_msg
    syscall


    li $v0, 5
    syscall
    move $a1, $v0
       
    jal id_isLegal
    move $t0,$v0
    bne $t0, 1, id_not_exists_balance    
   
    li $v0, 4
    la $a0, enter_new_balance_msg
    syscall
    li $v0, 5
    syscall
    move $a2, $v0
      
    jal balance_isLegal
    beqz $v0,invalid_balance
    
    j update_balance1
   
              

update_balance1:
      
    sw $a2, 104($v1)     
    move $a3,$v1
    jal  display_customer_help
    j main

id_not_exists_balance:
    li $v0, 4
    la $a0, id_not_exists_error_msg
    syscall
    
    li $v0,1    
    move $a0,$a1
    syscall
    
    li $v0, 4
    la $a0, id_not_exists_error_msg1
    syscall

    j main

exit_program:

    li $v0,4
    la $a0,exitmsg
    syscall
    
    li $v0, 10
    syscall
