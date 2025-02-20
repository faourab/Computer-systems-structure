.data 
user_Input: .space  16
pin:     .asciiz "Enter PIN: "
userinput2: .space 4
ATM_MENU:  .asciiz "\nMain menu:\n1. Check Balance\n2. Deposit Money\n3. Withdraw Money\n4. Exit\n"
           
CurrentBalance:  .asciiz "Current Balance: " 
erordepmore:     .asciiz "\nError: Deposit amount cannot exceed $5000\n"
erornotnum:     .asciiz "Error: Input is not legal\n"
exit:     .asciiz "Thank you for using ATM.Goodbye!\n"
pinerror:  .asciiz "Incorrect PIN\n"
pinerror1:  .asciiz "No attempt remaining.Exiting program\n"
EnterDepositamount: .asciiz "Enter deposit amount : "
Enterwithdrawamount: .asciiz "Enter withdraw amount: "
withdrawerror: .asciiz "Error: Insufficient funds or withdrawal limit exceeded"
Add:  .asciiz "Enter deposit amount: "
Sub: .asciiz "Enter withdrawal amount: "
.text 
main:
li $s0,1000     #currenBalance

ATM_MENU_PRINT:
li $v0,4
la $a0 ,ATM_MENU
syscall
start:
li $v0, 5           
syscall
move $t0, $v0 
beq $t0,1,Balance_print
beq $t0,2,ADD
beq $t0,3,SUB
beq $t0,4,Exit
bgt $t0,4,inputerror
blt,$t0,1,inputerror
ADD:
li $v0,4
la $a0,Add
syscall
li $v0, 5           
syscall
move $t0, $v0 
bgt $t0,5000,Error_depmore
add $s0,$s0,$t0 
j ATM_MENU_PRINT

SUB:
li $v0,4
la $a0,Sub
syscall
li $v0, 5           
syscall
move $t0, $v0 
bgt $t0,500,withdraw_error
blt $s0,$t0,withdraw_error
sub $s0,$s0,$t0
j ATM_MENU_PRINT

Balance_print:
li $v0,4
la $a0,CurrentBalance
syscall  
li $v0, 1
move $a0,$s0
syscall 
j ATM_MENU_PRINT

Error_depmore:
li $v0,4
la $a0,erordepmore
syscall 
j ATM_MENU_PRINT

Error_nutnum:
li $v0,4
la $a0,erornotnum
syscall 
j ATM_MENU_PRINT

Exit:
li $v0,4
la $a0,exit
syscall 
li $v0,10
syscall 

Error_pin:
li $v0,4
la $a0,pinerror
syscall
j ATM_MENU_PRINT

withdraw_error:
li $v0,4
la $a0,withdrawerror
syscall
j ATM_MENU_PRINT

inputerror:
li $v0,4 
la $a0,erornotnum
syscall 
j ATM_MENU_PRINT
Error_pin1:
li $v0,4 
la $a0,pinerror1
syscall 
li,$v0,10
syscall
j ATM_MENU_PRINT
