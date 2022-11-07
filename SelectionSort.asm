.data
	Array: .word 10, 2, 0, 15, 25, 30, 7, 22
	msg1: .asciiz "Array before sorting is: "
	msg2: .asciiz "\nArray after sorting is: "
.text
.globl main
main:
	
# 1	Printing msg1
	li $v0, 4 # system call code for print string
	la $a0, msg1 # loads address of prompt into $a0
	syscall # print the prompt message
	la $a1, Array # Array address
	li $a2, 8 # Size of the array
	jal printArray
	
# 2	Selection Sort
	
	jal SelectionSort
	
# 3	Printing msg2
	li $v0, 4 # system call code for print string
	la $a0, msg2 # loads address of prompt into $a0
	la $a1, Array # Array address
	li $a2, 8 # Size of the array
	syscall # print the prompt message
	jal printArray
	
	li $v0, 10
	syscall
# ---------------------
printArray:
	# args: $a1 : address of the array
	#	$a2 : size of the array
	move $t0, $a2 # loop counter
	li $t1, 0 # array index
Loop:
	addu $t2, $t1, $a1 # address of indexed element
	lw $a0, 0($t2)
	# Print the integer in a0
	li $v0, 1 # Load the system call number
	syscall
	# Printing a space 
	li $v0, 11
	li $a0, ' '
	syscall
	addi $t1, $t1, 4 # increment array index
	addi $t0, $t0, -1
	bgtz $t0, Loop
	jr $ra
# ---------------------
Swap: 	# Used regester: $t1, $t2
      	# args $a0, $a1 the addresses needs to swap
	lw $t1, 0($a0) # value of address one
	lw $t2, 0($a1) # value of address two
	sw $t2, 0($a0) # store $t2 in $a0 address
	sw $t1, 0($a1) # store $t1 in $a1 address 
	jr $ra # return to the last point call you
SelectionSort:
	# args: $a1 : address of the array
	#	$a2 : size of the array
	move $s0, $a1 # arr address of the array
	move $s1, $a2 # n size of the array 
	li $s2, 0 # i = 0
	la $t5, 0($ra)
F1: # for(int i = 0; i < n; i++)
	move $s3, $s2 # j = i
	move $s4, $s2 # m = i
	mul $a0, $s2, 4 # i*4
	addu $a0, $a0, $s0 # address of indexed element i
	
	
F2: # for(int j = i; j < n; j++)
	mul $s5, $s4, 4 # m*4
	addu $s5, $s5, $s0 # address of indexed element m
	lw $s5, 0($s5) # arr[m]
	
	mul $s6, $s3, 4 # j*4
	addu $s6, $s6, $s0 # address of indexed element j
	lw $s6, 0($s6) # arr[j]
	bgt $s6, $s5, N1 # arr[j] >= arr[m] ?
	move $s4, $s3 # m = j
	N1:
	addi $s3, $s3, 1 # j++
	ble $s3, $s1, F2 # j < n ?
End2:
	mul $a1, $s4, 4 # m*4
	addu $a1, $a1, $s0 # address of indexed element m
	
	jal Swap
	addi $s2, $s2, 1 # i++
	blt $s2, $s1, F1 # i < n ?
End1:
	jr $t5

	
