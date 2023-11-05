.include "macros.asm"
#.global main

#main:
.data
	one: .double 1.0
	minus_one: .double -1.0
	res: .double 0
.text
	fld fs1 one t0 # this is 1
	fld fs2 one t0 # for x
	fld fs3 one t0 # for sign 1
	fld fs4 minus_one t0 # for sign -1
	fcvt.d.w fs5 zero # this is the current n, while 0
	fmv.d fs6 fs1 # this is the current n!, while 1
	get_double
	fmv.d fs7 fa0 # x
	fld fs8 res t0 # res
	# below we pass all fsi as param. to func
	fmv.d fa0 fs1 # fa0 corresponds to fs1
	fmv.d fa1 fs2 # fa1 corresponds to fs2
	fmv.d fa2 fs3 # fa2 corresponds to fs3
	fmv.d fa3 fs4 # fa3 corresponds to fs4
	fmv.d fa4 fs5 # fa4 corresponds to fs5
	fmv.d fa5 fs6 # fa5 corresponds to fs6
	fmv.d fa6 fs7 # fa6 corresponds to fs7
	fmv.d fa7 fs8 # fa7 corresponds to fs8
	calculate_power_series # macro to calculate Taylor series
	
	print_double
	finish_with_code_0