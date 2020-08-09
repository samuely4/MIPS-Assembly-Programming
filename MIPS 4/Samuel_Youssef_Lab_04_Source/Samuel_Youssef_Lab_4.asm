		.data 							#data segment
n1: 		.asciiz "\n"						#ASCII for a new line
		.align 2						#aligned at word boundary
course: 	.asciiz "CSC343: "					#course name to be displayed
		.align 2						#aligned at word boundary
name:		.asciiz "Samuel Youssef "				#name
		.align 2						#aligned at word boundary
AndWord: 	.asciiz "and "						#"and" word to be displayed
		.align 2						#aligned at word boundary
ID: 		.asciiz "ID : 23402306"					#ID number to be dispalyed
		.align 2						# aligned at word boudary
input: 		.asciiz "Please enter a Fibonacci index number "	#statement at input to guide the user through input process
		.align 2						#aligned at word boundary
exitSmt:	.asciiz "(0 will stop the program) :"			#statement to appeat at input to guide the user to exit the program
		.align 2						#aligned at word boundary
leftPar: 	.asciiz "("						#left parenthesis
		.align 2						#aligned at word boundary
rightPar: 	.asciiz ") ="						#right parenthesis
		.align 2						#aligned at word boundary
Fsymbol: 	.asciiz "F"						#symbol of F to symbolize that it is a fibonacci number
		.align 2						#aligned at word boundary		
bye:		.asciiz "bye"						#bye to appear when the program is about to exit
		.align 2						#aligned at word boundary
toolarge:	.asciiz "the number is too large"			#too large number message to be printed out
		.align 2						#aligned at word boundary
negative:	.asciiz "the index is a negative number please try again"	#index entered is a negative number
		.align 2
		
		.text					#code segment 
		.globl main				#declare main to be global
main:

		li $v0, 4				#print string
		la $a0, course				#load course name
		syscall					#calling syscall to print string
		
		li $v0, 4				#print string
		la $a0, name				#loading name string to be printed
		syscall					#calling syscall to print string
		
		li $v0, 4				#print string
		la $a0, AndWord				#loading AndWord string to be printed
		syscall					# calling syscall to print string
		
		li $v0, 4				#print string
		la $a0, ID				#loading the ID string to be printed
		syscall					#calling syscall to print string
		
		li $v0, 4				#print string
		la $a0, n1				#loading new line string to be printed
		syscall					#calling syscall to print string
		
		addiu $t6, $zero, 1			#setting $t6 to 1 for comparison
		
loopInput:	li $v0, 4				#print string
		la $a0, input				#loading input statement to be printed on the screen
		syscall					#calling syscall to print string
		
		li $v0, 4				#print string
		la $a0, exitSmt				#loading directions on how to exit the program to be printed on the screen
		syscall					#calling syscall to print string
		
		li $v0, 5				#reading the index of fibonacci number
		syscall					#calling syscall to input index number
		
		move $t1, $v0				#saving the index number of fib number
		move $a0, $v0				#preparing for function call by setting argument a0 for function fibonacci
		
		beq $v0, $zero, exit1			#if input is equal to zero, the program exits
		slt $t7, $v0, $zero			#if index number inputted is negative
		bne $t7, $t6, notNegative		#the index is not negative, proceed
		
		li $v0, 4				#system call to print string
		la $a0,Fsymbol				#loading the address of leftPar to be printed 
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0,leftPar				#loading the address of leftPar to be printed
		syscall					#call to OS
		
		li $v0, 1				#system call to print integer
		la $a0, ($t1)				#loading address of index of fib number
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, rightPar			#loading the address of rightPar
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, negative			#loading the address of rightPar
		syscall					#call to OS
		
		li $v0, 4				#print string
		la $a0, n1				#loading new line string to be printed
		syscall					#calling syscall to print string
		j continueProc				#continue input loop process

		
		
		
notNegative:	
		jal fibonacci2				#calling the function	
		
		move $t0, $v0				#move return value of v0 to t0
		slt $t2, $v0, $zero			#if the return number is 0xffffffff which is -1 is less than zero
		beq $t2,$zero,repeatloop		#jump directly to repeat loop to repeat the loop with printing out fib number.
		
		li $v0, 4				#system call to print string
		la $a0,Fsymbol				#loading the address of leftPar to be printed 
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0,leftPar				#loading the address of leftPar to be printed
		syscall					#call to OS
		
		li $v0, 1				#system call to print integer
		la $a0, ($t1)				#loading address of index of fib number
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, rightPar			#loading the address of rightPar
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, toolarge			#loading the address of rightPar
		syscall					#call to OS
		
		li $v0, 4				#print string
		la $a0, n1				#loading new line string to be printed
		syscall					#calling syscall to print string
		j continueProc				#continue input loop process

repeatloop:
		li $v0, 4				#system call to print string
		la $a0,Fsymbol				#loading the address of leftPar to be printed 
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0,leftPar				#loading the address of leftPar to be printed
		syscall					#call to OS
		
		li $v0, 1				#system call to print integer
		la $a0, ($t1)				#loading address of index of fib number
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, rightPar			#loading the address of rightPar
		syscall					#call to OS
		
		
		li $v0, 1				#print integer
		la $a0, ($t0)				#moving address of fib number to be printed out
		syscall					#making the system call
		
		li $v0, 4				#print string
		la $a0, n1				#loading new line string to be printed
		syscall					#calling syscall to print string

continueProc:
		j loopInput				#call to repeat the loop for the user to input another index of fib number

		
exit1:	        
		li $v0, 4				#print string
		la $a0, bye				#loading bye message to be printed on the screen
		syscall					#calling syscall to print string
		li $v0, 10				#system call type 10, standard exit
		syscall					#call to OS 



#registers used inside this function
#a0 to store the argument of the function
#s0 to store constant 1
#s1 to store constant zero
#s2 to store constant 100
#s3 to store constant -1
#s4 to store boolean value of comparison
#s5 to store the result of addition between f[n-1] and f[n-2]
#s6 to store the value of v0
#s7 to store the value of v1
#-----------------Fibonacci2 fucntion---------------------------
		.globl fibonacci2 				#making the function print global to be accessed by other files
fibonacci2:							#label function

		addi $sp, $sp, -40			#adding space for register used in the function on the stack
		sw $ra, 36($sp)				#saving register ra on the stack
		sw $a0, 32($sp)				#saving a0 on the stack
		sw $s7, 28($sp)				#saving register s7 on the stack
		sw $s6, 24($sp)				#saving register s6 on the stack
		sw $s5, 20($sp)				#saving register s5 on the stack
		sw $s4,	16($sp)				#saving register s4 on the stack
		sw $s3, 12($sp)				#saving register s3 on the stack
		sw $s2, 8($sp)				#saving register s2 on the stack
		sw $s1, 4($sp)				#saving register s1 on the stack
		sw $s0, 0($sp)				#saving register s0 on the stack
		
		addiu $s0, $zero, 1			#setting s0 equal to 1 for comparison
		move $s1, $zero				#setting s1 to zero. later used in comparison 
		addiu $s2, $zero, 100			#setting s2 to 100 for comparison
		addiu $s3, $zero, -1			#setting s3 = -1 to be used later
		move $s4, $zero				#moving zero to register s4 to be later used in comparison
		move $s5, $zero				#s5 used in the addition process inside the recursive function  
		
		
		
		bne $a0, $s1, label1			#branch to label1 if a0 != 0
		move $v0, $zero				#move to v0 (later assigned to v0) zero
		move $v1, $zero				#move to v1 (later assigned to v1) zero
		lw $a0, 32($sp)				#restoring register a0 from the stack
		lw $ra, 36($sp)				#restoring register ra from the stack
		addi $sp, $sp, 40			#restoring the stack pointer
		jr $ra					#return
		
label1:        
		bne $a0, $s0, label2			#branch to label2 if a0 != 1
		move $v0, $s0				#setting v0 to 1
		move $v1, $zero				#setting v1 to 0
		lw $a0, 32($sp)				#restoring register a0 from the stack
		lw $ra, 36($sp)				#restoring register ra from the stack
		addi $sp, $sp, 40			#restoring the stack pointer
		jr $ra					#return
		
label2:		
		sgtu $s4, $a0, $s2			#s4 == 1 if a0 == 100
		bne $s4, $s0, label3			#branch to label3 if a1 !> 100
		move $v0, $s3				#setting v0 to value of s3 which is -1
		lw $a0, 32($sp)				#restoring register a0 from the stack
		lw $ra, 36($sp)				#restoring register ra from the stack
		addi $sp, $sp, 40			#restoring the stack pointer
		jr $ra					#return 
		
label3: 	
		addiu $a0, $a0, -1			#decrementing a0
		jal fibonacci2				#recursive call
			
		move $s6, $v0				#getting the F[n-1]
		move $s7, $v1				#getting the F[n-2]
		beq $s6, $s3, exit2			#exiting if the index of fibonacci number is out of bounds that we can calculate (>100)
		addu $s5, $s6, $s7			#adding the two elements F[n-1] and F[n-2] to get F[n]. value of F[n] is saved in s5
		slt $s4, $s5, $zero			#checking if there is overflow as a result of the addition.
		bne $s4, $zero, label4			#if there is overflow jump to label4 
		move $s7, $s6				#setting the correct value for v0			
		move $s6, $s5				#setting the correct value for v1
		
		j exit2					#jumping to exit2 after calculating new F[n] and F[n-1] for return
		
label4: 	

		move $v0, $s3				#setting v0 to value of s3 which is -1
		lw $a0, 32($sp)				#restoring register a0 from the stack
		lw $ra, 36($sp)				#restoring register ra from the stack
		addi $sp, $sp, 40			#restoring the stack pointer
		jr $ra					#return
		
exit2:		
		
		move $v0, $s6				#putting the final value of $v0 in $v0
		move $v1, $s7				#putting the final value of $v1 in $v1	
		lw $s0, 0($sp)				#restoring register s0 from the stack
		lw $s1, 4($sp)				#restoring register s1 from the stack
		lw $s2,	8($sp)				#restoring register s2 from the stack
		lw $s3, 12($sp)				#restoring register s3 from the stack
		lw $s4, 16($sp)				#restoring register s4 from the stack
		lw $s5, 20($sp)				#restoring register s5 from the stack
		lw $s6, 24($sp)				#restoring register s6 from the stack
		lw $s7, 28($sp)				#restoring register s7 from the stack
		lw $a0, 32($sp)				#restoring register a0 from the stack
		lw $ra, 36($sp)				#restoring register ra from the stack
		addi $sp, $sp, 40			#restoring the stack pointer
		jr $ra					#returning to caller				
							
								
								
										
											
												
													
														
															
														
															
																
																	
																		

	
		
			
				
					
						
							
								
									
										
											
	
