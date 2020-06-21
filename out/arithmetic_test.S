.globl _start
.section .text
_start:
		LBU	x18,-971(x30)
		LBU	x18,289(x2)
		LH	x5,483(x29)
		LW	x8,-31(x10)
		LHU	x17,-621(x31)
		LH	x19,-1318(x30)
		LB	x5,-1856(x22)
		LH	x24,1121(x9)
		LW	x7,-1228(x2)
		LB	x14,-1076(x25)
		LBU	x31,-859(x27)
		LBU	x6,-73(x14)
		LHU	x17,-1825(x1)
		LW	x10,-172(x26)
		LB	x23,1975(x0)
		LB	x11,-651(x18)
		LBU	x12,-473(x17)
		LH	x15,1280(x25)
		LBU	x31,1624(x12)
		LH	x15,-708(x19)
		LB	x31,885(x23)
		LW	x18,1063(x28)
		LBU	x23,1556(x23)
		LHU	x5,1425(x10)
		LH	x24,-32(x12)
		LH	x13,1280(x11)
		LW	x30,-274(x11)
		LW	x7,-603(x31)
		LB	x6,1532(x19)
		LHU	x30,2004(x21)
		LBU	x7,-38(x20)
		LHU	x13,1270(x4)
_main:
		SH	x30,1133(x2)
		SW	x31,-1269(x8)
		LH	x3,710(x20)
		AUIPC	x24,392066
		SH	x8,276(x18)
		LHU	x14,1012(x23)
		LB	x29,-1300(x20)
		LH	x2,-465(x5)
		LUI	x28,337035
		LB	x10,1688(x16)
		LBU	x24,319(x29)
		SLTI	x23,x9,-1042
		SW	x24,-343(x11)
		LB	x23,1436(x9)
		ADDI	x21,x14,421
		SH	x7,1405(x27)
		SW	x18,574(x28)
		SW	x2,-558(x2)
		SH	x26,1277(x10)
		SLTI	x15,x30,-324
		SW	x1,80(x3)
		AUIPC	x0,420391
		SH	x9,1998(x11)
		SRL	x6,x26,x31
		ANDI	x30,x10,1387
		LBU	x27,1226(x2)
		SLL	x23,x20,x20
		ADD	x9,x0,x20
		LBU	x15,1350(x2)
		ORI	x21,x1,-1361
		SLL	x4,x30,x28
		SH	x21,-453(x14)
		LH	x12,-298(x31)
		LHU	x11,1787(x28)
		OR	x6,x11,x18
		SB	x25,1285(x24)
		SB	x19,1400(x25)
		SB	x10,1946(x13)
		ADDI	x17,x25,-1555
		AUIPC	x2,51459
		LW	x26,-815(x4)
		SH	x23,-536(x23)
		ANDI	x12,x23,132
		SW	x9,-133(x30)
		LB	x6,-1514(x0)
		SRL	x16,x7,x15
		LHU	x6,119(x5)
		SH	x0,262(x21)
		SH	x23,-432(x2)
		SW	x24,1855(x12)
8:
		SH	x28,1273(x8)
test_done:
		SW	x30,-349(x25)
write_tohost:
		SB	x30,902(x28)
_exit:
		SW	x17,-222(x18)
		SB	x1,843(x20)
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
