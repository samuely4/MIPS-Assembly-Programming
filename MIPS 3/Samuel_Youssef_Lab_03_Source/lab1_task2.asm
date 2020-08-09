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
FBN:		.space 400				#array to hold fib numbers 
		.align 2				#aligned at word boundary
NUM_FBN: 	.space 4				#allocating space to hold the index number
		.align 2				#aligned at word boundary
		
		.text					#code segment
		.globl main				#declare main to be global
main:

		move $s0, $zero				#s0 holds f[0] = 0
		addiu $s1, $zero, 1			#s1 hold f[1] = 1
		la $t0, FBN				#t0 holds the address of the Fib array
		move $t1, $zero			#t1 to increament index value
		addu $t2, $t1, $t0			#t2 to hold current array element being assigned
		sw $s0, 0($t2)				#saving s0 = 0 into the first in index 0 of array fib
		addiu $t1, $t1, 4			#increasing the index
		addu $t2, $t1, $t0			#getting access to the appropriate index for writitng
		sw $s1, 0($t2)				#saving s1 = 1 into index 1 of array fib
		la $s3, NUM_FBN				#hold the address of num_fbn
		
		
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
		
		addiu $t8, $zero, 4			# N = 1
		move $t3, $zero				#holds element F[n-1]
		move $t4, $zero				#holds element F[n]
		move $t7, $zero				#holds the address of f[n-1]
		move $t9, $zero				#holds the address of f[n]
		move $s2, $zero				#hold the boolean value to check if a certain register is greater or less than zero

loop: 							#label of loop
		move $t5, $t8				#holds the value of N (tracking index f[n-1])
		move $t6, $t8				#holds the value of N (tracking index f[n])
		addi $t5, $t5, -4			#doing N-1
		add $t7, $t0, $t5			#getting the address of f[n-1]
		add $t9, $t0, $t6			#getting the address of f[n]
		lw $t3, 0($t7)				#getting the element f[n-1]
		lw $t4, 0($t9)				#getting the element f[n]
		addu $t4, $t4, $t3			#doing unsigned addition on f[n-1] and f[n]
		slt  $s2, $t4, $zero			#checking if the addition is overflow or not
		bne $s2, $zero, continuetoPrint		#end of operation (overflow exits) going to print loop
		addi $t8, $t8, 4			#keeping track of the index of the element
		sw $t4, 4($t9)				#assigning appropriate element of the array
		j loop					#looping until overflow happens
		 
		 
continuetoPrint: 
		sw $t8, 0($s3)				#assigning num_fbn to the number of time computation loop happened
		move $t8, $zero				#writing a new value to t8 = 0.
		move $s4, $zero				#holds the address of the element being printed out
		li  $s5, 4				#holds a constant number 4
		move $s6, $zero				#holds content of num_fbn 
		 	
loopPrint:
		addu $s4, $t0, $t8			#having the correct current address of element printing out saved into s4
		div $t8, $s5				#having the index number calculated
		mflo $a1				#moving the index from the lo register to a1
		lw $a2, 0($s4)				#loading the element in a2
		jal print				#calling the function of print
		addi $t8, $t8, 4			#adding 4 bytes for the index of the next element
		lw $s6, 0($s3)				#loading the number of elements we have computed
		slt $s2, $t8, $s6			#check if we exceeded the number of elements we have originally calculated by comparing to t8
		beq $s2, $zero, terminate		#if t8 is greater than the number of elements that we have calculated, we terminate the program 
		j loopPrint				#reiterate the loop if condition in last statement is not satisfied

				
terminate:						# printing the last element of the array

		addu $s4, $t0, $t8			#having the correct current address of element printing out saved into s4
		div $t8, $s5				#having the index number calculated
		mflo $a1				#moving the index from the lo register to a1
		lw $a2, 0($s4)				#loading the element in a2
		jal print				#calling the function of print
		
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

