# MIPS - Calculator
.data
	welcome: .asciiz "Welcome to my MIPS calculator!"
	
	#menu option string
	menu: .asciiz "\n\nMenu options:\n1. Addition (C = A + B)\n2. Subtraction (C = A - B)\n3. Multiplication (C = A × B)\n4. Division (C = A / B)\n5. Modulo (C = A % B)\n6. Square (C = A ^ 2)\n7. Area of Triangle A =(H ^ B)/2 \n8. Factorial (N! = N × (N-1) × (N-2)...×1)\n9. Sum(A,B) (C = A + A+1 + A+2 ... + B) where (A<B)\n10. AND (Bitwise Operation)\n11. OR (Bitwise Operation)\n12. XOR (Bitwise Operation)\n13.Exit the Program\nPlease enter an option: "

	#selection strings
	opt1: .asciiz "You have selected addition operation. A + B = C\n"
	opt2: .asciiz "You have selected subtraction operation. A - B = C\n"
	opt3: .asciiz "You have selected multiplication operation. A * B = C\n"
	opt4: .asciiz "You have selected division operation. A / B = C\n"
	opt5: .asciiz "You have selected modulo operation. A % B = C\n"
	opt6: .asciiz "You have selected square operation. A ^ 2 = C\n"
	opt7: .asciiz "You have selected Area operation. A= (H*B)/2 \n"
	opt8: .asciiz "You have selected factorial operation. N!\n"
	opt9: .asciiz "You have selected sum(A,B) operation. A + A+1 + A+2 ... +B\n"
	opt10: .asciiz "You have selected AND operation. C = A && B\n"
	opt11: .asciiz "You have selected OR operation. C = A || B\n"
	opt12: .asciiz "You have selected XOR operation. C = A ? B\n"
	opt13: .asciiz "You have selected exiting the program.\nProgram Terminated.\n"
	wrongopt: .asciiz "Invalid choice. Please try again.\n"

	answer: .asciiz "The answer is: "

	enterA: .asciiz "Please enter A: "
	enterB: .asciiz "Please enter B: "
	enterhei: .asciiz "Please enter height: "
	enterbas: .asciiz "Please enter base: "
	enterN: .asciiz "Please enter N: "
	wrongFac: .asciiz "Invalid input. Pleasee enter a positive integer.\n"
	wrongSumMsg: .asciiz "Invalid input. Input must be B > A. Please try again.\n"
	divZero: .asciiz "Can't divide by zero. Please try again.\n"	
	

.text
	.globl main
main:
	#print welcoming message
	li $v0, 4
	la $a0, welcome
	syscall

printMenu:
	#print menu options
	li $v0, 4
	la $a0, menu
	syscall

	#read menu option int
	li $v0, 5
	syscall
	
	move $t0, $v0	#chosen menu option is stored in $t0
	
	beq $t0, 1 , addition	
	beq $t0, 2 , subtraction
	beq $t0, 3 , multiplication
	beq $t0, 4 , division
	beq $t0, 5 , mod
	beq $t0, 6 , square
	beq $t0, 7 , Area
	beq $t0, 8 , factorial
	beq $t0, 9 , sumNtoM	
	beq $t0, 10, boolAnd
	beq $t0, 11, boolOr
	beq $t0, 12, boolXor
	beq $t0, 13, exit

	#in case user inputs invalid integer, print invalid message and reprint menu
	li $v0, 4
	la $a0, wrongopt
	syscall
	
	j printMenu

addition:
	#print addition message
	li $v0, 4
	la $a0, opt1
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	add $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


subtraction:
	#print subtraction message
	li $v0, 4
	la $a0, opt2
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	sub $s2, $s0, $s1	#s2 = A - B

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

multiplication:
	#print multiplication message
	li $v0, 4
	la $a0, opt3
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	mult $s0, $s1	#s2 = A * B
	mflo $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

	

division:
	#print division message
	li $v0, 4
	la $a0, opt4
	syscall

	divLoop:
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	beq $s1, 0, divByZero

	#calculations:
	div $s0, $s1	#s2 = A / B
	mflo $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

divByZero:
	
	#print can't divide by zero
	li $v0, 4
	la $a0, divZero
	syscall
	j divLoop
	
mod:
	#print modulo message
	li $v0, 4
	la $a0, opt5
	syscall
	
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	div $s0, $s1	#s2 = A % B
	mfhi $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu
square:
	#print square message
	li $v0, 4
	la $a0, opt6
	syscall
	
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#calculations:
	mult $s0, $s0	#s2 = A * A
	mflo $s2

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu
	
Area:
	#print multiplication message
	li $v0, 4
	la $a0, opt7
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterhei
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterbas
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	mult $s0, $s1	#s2 = A * B
	mflo $s2
	
	div  $s2,$s2,2
	
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

	

factorial:
	#print factorial message
	li $v0, 4
	la $a0, opt8
	syscall
	
factorialLoop:
	#print please enter N
	li $v0, 4
	la $a0, enterN
	syscall

	#read N
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = N, which is also the number of repetition

	blt	$s0, 0, wrongFactorial
	blt $s0, 2, factorialOne	#either one or zero, N! = 1
		
	#else (N > 1)
	li $s2, 1			#$s2 is result, it is initialized to 1
	factorialCalculation:
	mult $s2, $s0
	mflo $s2
	addi $s0, $s0, -1
	bgt	$s0, 0, factorialCalculation
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
			
	j printMenu

wrongFactorial:
	#print invalid msg
	li $v0, 4
	la $a0, wrongFac
	syscall
	j factorialLoop

factorialOne:
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	li $a0, 1
	syscall
		
	j printMenu
	

sumNtoM:
	#print sum from n to m message
	li $v0, 4
	la $a0, opt9
	syscall

sumLoop:
	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A

	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	ble	$s1, $s0, wrongSum

	#else, which means valid sum
	#calculations:
	li $s2, 0				#$s2 (result) is initialized to 0 (sum neutral)
	
sumCalcLoop:
	add $s2, $s2 , $s0
	addi $s0, $s0, 1
	ble $s0, $s1, sumCalcLoop
	
	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

wrongSum:
	#print invalid sum msg
	li $v0, 4
	la $a0, wrongSumMsg
	syscall
	j sumLoop

boolAnd:
	#print AND message
	li $v0, 4
	la $a0, opt10
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	and $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu


boolOr:
	#print AND message
	li $v0, 4
	la $a0, opt11
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	or $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

boolXor:
	#print XOR message
	li $v0, 4
	la $a0, opt12
	syscall

	#print please enter A
	li $v0, 4
	la $a0, enterA
	syscall

	#read A
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = A


	#print please enter B
	li $v0, 4
	la $a0, enterB
	syscall

	#read B
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = B

	#calculations:
	xor $s2, $s0, $s1

	#print result
	li $v0, 4
	la $a0, answer
	syscall
	li $v0, 1
	move $a0, $s2
	syscall

	#return to menu
	j printMenu

exit:
	#print exit msg
	li $v0, 4
	la $a0, opt13
	syscall

	#exit the program
	li $v0 ,10
	syscall


	
