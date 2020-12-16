# COMP 411 FALL 2020 LAB 4 STARTER CODE
# Jill Pownall
# 9/24/2020

.data 0x0
  executionTime:		.word 0
  numberOfProcessors:	.word 0 
  totalPrice:		.word 0
  price:                .word
  cpi:                  .word
  
  
  timePrompt:		.asciiz "Please enter the desired execution time (in seconds): "	
  pricePrompt:		.asciiz "Please enter the price of the processor(in dollars): "
  cpiPrompt:		.asciiz "Please enter the average CPI of the processor: "
  executionTimeIs:	.asciiz "Execution time in seconds: "
  isDesired:		.asciiz "This processor meets the desired execution time, adding to cart."
  notDesired:		.asciiz "This processor does not meet the desired execution time."
  totalProcessors:	.asciiz "Total number of processors purchased: "
  isTotalPrice:		.asciiz "Total price of processors purchased: "
  doneShopping:		.asciiz "You are done shopping for processors."
  newline:			.asciiz "\n"

 .text
main:
 # Print the prompt for time
  addi 	$v0, $0, 4  	# system call 4 is for printing a string
  la 		$a0, timePrompt 	# address of timePrompt is in $a0
  syscall           		# print the string
 
  # Read the Execution TIme
  addi	$v0, $0, 5		# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  add	$8, $0, $v0			# copy the execution time into $8
  sw 	$s0, numberOfProcessors	# number of Processors stored in $s0
  sw 	$s1, totalPrice		# total Price stored in $s1
  sw 	$s2, cpi
  sw    $s3, price
  sw    $s4, executionTime
  j	loop	
 		
loop:
  # TO-DO: Complete the body of the loop.
  # Use the system calls provided above for input/output as a template for handling strings.
  #================================================================================================#
  while:
  	beqz $8, exit
        
  	addi $v0, $0, 4 #print string
  	la $a0, pricePrompt 
  	syscall #print price promt
  	addi $v0, $0, 5 #read int
  	syscall
  	add $t1, $0, $v0
  	
        beqz $t1, exit #if price = 0

     	
        addi $v0, $0, 4 #print string
  	la $a0, cpiPrompt 
  	syscall #print cpi prompt
  	addi $v0, $0, 5 #read int
  	syscall
  	add $s2, $0, $v0
  	
  	addi $v0, $0, 4 #print string
  	la $a0, executionTimeIs
  	syscall
  	addi $s4, $zero, 0
  	sll $s4, $s2, 3
  	srl $s4, $s4, 2
  	li $v0, 1
  	move $a0, $s4
  	syscall
  	addi $v0, $0, 4
  	la $a0, newline
  	syscall
  		
        ble $s4, $8, then
        addi $v0, $0, 4
  	la $a0, notDesired
  	syscall
  	addi $v0, $0, 4
  	la $a0, newline
  	syscall
  	j endif2
      then:
        addi $v0, $0, 4
  	la $a0, isDesired
  	syscall
  	addi $v0, $0, 4
  	la $a0, newline
  	syscall
  	add $s1, $s1, $t1
  	addi $s0, $s0, 1
      endif2:
  	
  
 
  	j while
  	
        
  
  
  #================================================================================================#
exit:
  # TO-DO: Complete the behavior of the program after exiting the loop.
  # Indicate that we have left the loop and output the number of processors and total price.
  #================================================================================================#
       addi $v0, $0, 4     
       la $a0, doneShopping  
       syscall   
       addi $v0, $0, 4
       la $a0, newline
       syscall   
              
       addi $v0, $0, 4     
       la $a0, totalProcessors
       syscall    
       li $v0, 1
       move $a0, $s0
       syscall
       addi $v0, $0, 4
       la $a0, newline
       syscall  
       
       addi $v0, $0, 4     
       la $a0, isTotalPrice 
       syscall  
       li $v0, 1
       move $a0, $s1
       syscall
       addi $v0, $0, 4
       la $a0, newline
       syscall         
 
 
 
  #================================================================================================#
  
  # Boilerplate system call to terminate program.
  ori $v0, $0, 10       	# system call code 10 for exit
  syscall   			
