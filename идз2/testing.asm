.include "macros.asm"
.global main

.macro test(%x) # macro that allows testing
.data
	x: .double %x
	one: .double 1.0
	minus_one: .double -1.0
	res: .double 0 # res = resulted expression 
.text
	fld fs1 one t0 # this is 1
	fld fs2 one t0 # created for x
	fld fs3 one t0 # for sign 1
	fld fs4 minus_one t0 # for sign -1
	fcvt.d.w fs5 zero # this is the current n, while 0
	fmv.d fs6 fs1 # this is the current n!, while 1
	fld fs7 x t0
	fld fs8 res t0 # res
	
	# below we pass all fsi as param. to func
	fmv.d fa0 fs1
	fmv.d fa1 fs2
	fmv.d fa2 fs3
	fmv.d fa3 fs4
	fmv.d fa4 fs5
	fmv.d fa5 fs6
	fmv.d fa6 fs7
	fmv.d fa7 fs8
	calculate_power_series # func is hidden inside macro
	
	print_double
.end_macro

main:
.text
	test(1.13)
	test(2.13)
	test(4.13)
	test(-1.13)
	test(-2.13)
	test(-4.13)
	test(0)
	finish_with_code_0