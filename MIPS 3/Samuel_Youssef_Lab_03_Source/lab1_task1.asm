		.data 					#data segment
n1: 		.asciiz "\n"				#ASCII for a new line
		.align 2				#aligned at word boundary
course: 	.asciiz "CSC343: "			#course name to be displayed
		.align 2				#aligned at word boundary
name:		.asciiz "Samuel Youssef "		#name
		.align 2				#aligned at word boundary
AndWord: 	.asciiz "and "				#"and" word to be displayed
		.align 2				#aligned at word boundary
ID: 		.asciiz "ID : 23402306"			#ID number to be dispalyed
		.align 2				# aligned at word boudary
Fibword: 	.asciiz "The Fibonacci Number F" 	#fibonacci string to be displayed
		.align 2				#aligned at word boundary
leftPar: 	.asciiz "("				#left parenthesis
		.align 2				#aligned at word boundary
rightPar: 	.asciiz ") "				#right parenthesis
		.align 2				#aligned at word boundary
isString:	.asciiz"is "				#is word to be displayed
		.align 2				#aligned at word boundary
		
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
		
		
		li $t0, 0				#intial value of F(n-2)
		li $t1, 1				#intial value of F(n-1)
		
		addiu $s7, $0 , 1			#s7 holds the current index for the fib number to be calculated
		move $a1, $t0				#moving the first argument in s1 to a1
		move $a2, $t1				#move the second argument in s2 to a2
		jal print				#call to function
		 
		
loop: 							#label of loop
		addiu $s7, $s7, 1			#adding 1 to current index
		add $t2, $t0, $t1			#adding the past two elements F(n-2)--> t0  and F(n-1)--> t1 and putting the result in t2
		move $a1, $s7				#moving the first argument in s1 to a1
		move $a2, $t2				#move the second argument in s2 to a2
		jal print				#calling function to print out the fib number
		move $t0, $t1				#reassinging F(n-2)
		move $t1, $t2				#reassinging F(n-1)
		slti $t4, $s7, 10 			#set t4 to 1 if value in s7 is less than 10
		beq  $t4, 1, loop			#branch if value in t4 = 1 to loop
		
		
		
		li $v0, 10				#system call type 10, standard exit
		syscall					#call to OS
		

#list of registers used in print function
# 1) v0--> used to load system service numbers
# 2) a0--> used to load address of integer/string beign printed
# 3) s0--> used to hold the index of fib number
# 4) s1--> used to hold the fib number		
		
# ------------------------- function print implementation--------------------------		
		.globl print 				#making the function print global to be accessed by other files
print:							#label function
		li $v0, 4				#system call to print string
		la $a0, Fibword				#loading the address of fibword to be printed
		syscall					#call to OS
		
		addiu $sp,$sp, -12			#adjust the stack for 2 items(arguments of the function)
		sw $ra, 8($sp)				#saving the return address on the stack
		sw $s0, 4($sp)				#saving the content of the register s0 to be used inside the function
		sw $s1, 0($sp)				#saving the content of register  s1 to be used in the function
		
		move $s0, $a1				#moving the content of a1 (index of the element) to s0
		move $s1, $a2				#moving the content of a2 (element) to s1
		
		li $v0, 4				#system call to print string
		la $a0,leftPar				#loading the address of leftPar to be printed
		syscall					#call to OS
		
		li $v0, 1				#system call to print integer
		la $a0, ($s0)				#loading address of index of fib number
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, rightPar			#loading the address of rightPar
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, isString			#loading address of isString
		syscall					#call to OS
		
		li $v0, 1				#system call to print integer
		la $a0, ($s1)				#loading address of fib number
		syscall					#call to OS
		
		li $v0, 4				#system call to print string
		la $a0, n1				#loading address of new line
		syscall					#call to OS
		
		lw $s1, 0($sp)				#restoring the content of the register s1
		lw $s0, 4($sp)				#restoring the content of the register s0
		lw $ra, 8($sp)				#restoring the content of the register ra 
		addiu $sp, $sp, 12			#restoring stack pointer
		
		jr $ra					#return statement 




		
	

	
 
