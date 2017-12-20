[BITS 32]
	MOV		AL,'A'
	CALL    2*8 : 0xBD9
fin:
	HLT
	JMP		fin
