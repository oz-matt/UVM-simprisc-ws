.globl _start
.section .text
_start:
		LBU	x18,x30,-971
		LBU	x18,x2,289
		LH	x5,x29,483
		LW	x8,x10,-31
		LHU	x17,x31,-621
		LH	x19,x30,-1318
		LB	x5,x22,-1856
		LH	x24,x9,1121
		LW	x7,x2,-1228
		LB	x14,x25,-1076
		LBU	x31,x27,-859
		LBU	x6,x14,-73
		LHU	x17,x1,-1825
		LW	x10,x26,-172
		LB	x23,x0,1975
		LB	x11,x18,-651
		LBU	x12,x17,-473
		LH	x15,x25,1280
		LBU	x31,x12,1624
		LH	x15,x19,-708
		LB	x31,x23,885
		LW	x18,x28,1063
		LBU	x23,x23,1556
		LHU	x5,x10,1425
		LH	x24,x12,-32
		LH	x13,x11,1280
		LW	x30,x11,-274
		LW	x7,x31,-603
		LB	x6,x19,1532
		LHU	x30,x21,2004
		LBU	x7,x20,-38
		LHU	x13,x4,1270
_main:
		LH	x3,x20,710
		LHU	x14,x23,1012
		LB	x29,x20,-1300
		LH	x2,x5,-465
		LB	x10,x16,1688
		LBU	x24,x29,319
		LB	x23,x9,1436
		LBU	x27,x2,1226
		LBU	x15,x2,1350
		LH	x12,x31,-298
8:
		LHU	x11,x28,1787
test_done:
		LW	x26,x4,-815
write_tohost:
		LB	x6,x0,-1514
_exit:
		LHU	x6,x5,119
		LB	x10,x8,425
.data
.pushsection .tohost,"aw",@progbits;
.align 6;
.global tohost;
tohost:
                .dword 0;
.align 6;
.global fromhost;
fromhost:
                .dword 0;
.popsection;
