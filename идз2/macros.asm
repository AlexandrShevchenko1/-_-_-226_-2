.macro get_double
.text
	li a7 7
	ecall
.end_macro

.macro print_double
.text
	li a7 3
	ecall
	li a0, 10    # Loading ASCII newline code
    	li a7, 11    # Calling a system call to print a character
	ecall
.end_macro

.macro finish_with_code_0
.text 
	li a7 10
	ecall
.end_macro

.macro calculate_power_series
.text
	jal get_tan
.end_macro