.global get_tan

.data
	two_pi: .double 6.283185307179586 # 2pi
  	thpi_t: .double 4.71238898038469 # 3pi/2
  	pi_t: .double 1.5707963267948966 # pi/2
 	m_one: .double -1.0
.text
get_tan:
	addi sp sp -44 # allocate space in stack
	sw ra 40(sp) # for code scalability we save ra in stack
	li t0 1 # cnt
	sw t0 36(sp) # saving t0 to stack as it is temp. "variable"
	li t1 20 # number of summands = t1 - 1 (more summands we have the more precise result will be)
	sw t1 32(sp)
	li t2 2 # t2 = 2
	sw t2 28(sp)
	loop: # find taylor series for sin(x)
		remu t3 t0 t2 # checking the parity of the iteration
		sw t3 24(sp)
		
		fmul.d fa1 fa1 fa6 # x^n = x^(n-1)*x
		fadd.d fa4 fa4 fa0 # n = n + 1
		fmul.d fa5 fa5 fa4 # n! = (n-1)! * n
		fdiv.d ft0 fa1 fa5 # x^n/n!
		fsd ft0 16(sp)
		
		bnez t3 else # if iteration is even we skip
		j skip
		else:
			fmul.d ft0 ft0 fa2
			fadd.d fa7 fa7 ft0 # adding another summand to a series
			fmul.d fa2 fa2 fa3 # change the sign
		skip:
			addi t0 t0 1
		 	bne t0 t1 loop
	li t1 1
	fcvt.d.w fa1 t1 
	fnmsub.d fa2 fa7 fa7 fa1 # 1 - sin^2(x)
	fsqrt.d ft1 fa2 # cos(x)
	fsd ft1 8(sp)
	
	# define the sign of the cos
	fabs.d fa6 fa6 # mod(x)
	fld ft0 two_pi t0
	li t1 1
	decrease:
	    flt.d t0 fa6 ft0 
	    beq t1 t0 stop 
	    fsub.d fa6 fa6 ft0
	    j decrease
	    stop:
		    fld ft3 thpi_t t0
		    flt.d t0 fa6 ft3
		    fld ft4 pi_t t0
		    fgt.d t1 fa6 ft4
		    mul t1 t1 t0
		    bnez t1 change_sign
	    	    j continue
	    change_sign:
		      fld ft3 m_one t0
		      fmul.d ft1 ft3 ft1
	continue:
		
	
	fdiv.d ft2 fa7 ft1 # tan
	fsd ft2 (sp)
	
	lw ra 40(sp)
	lw t0 36(sp)
	lw t1 32(sp)
	lw t2 28(sp)
	lw t3 24(sp)
	fld ft0 16(sp)
	fld ft1 8(sp)
	fld ft2 (sp)
	addi sp sp 44 # free stack				
	fmv.d fa0 ft2
	ret