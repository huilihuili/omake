[BITS 32]
	MOV		AL,'A'
	CALL    0xBD9
fin:
	HLT
	JMP		fin
