; naskfunc
; TAB=4

[FORMAT "WCOFF"]				; 制作目标文件的模式	
[BITS 32]						; 制作32位模式用的机器语言
[INSTRSET "i486p"]				; 使用到486为止的指令
[FILE "naskfunc.nas"]			; 源文件名信息


; 制作目标文件的信息



	GLOBAL	_io_hlt, _io_cli, _io_sti, _io_stihlt	; 程序中包含的函数名
	GLOBAL	_io_in8, _io_in16, _io_in32
	GLOBAL	_io_out8, _io_out16, _io_out32
	GLOBAL	_io_load_eflags, _io_store_eflags
	GLOBAL	_load_gdtr, _load_idtr
	GLOBAL	_load_cr0, _store_cr0
	GlOBAL	_load_tr
	GlOBAL	_asm_inthandler20, _asm_inthandler21, _asm_inthandler27, _asm_inthandler2c
	GLOBAL	_asm_cons_putchar
	GLOBAL	_memtest_sub
	GLOBAL	_taskswitch3, _taskswitch4
	GLOBAL	_farjmp, _farcall
	EXTERN	_inthandler20, _inthandler21, _inthandler2c, _inthandler27
	EXTERN	_cons_putchar

; 以下是实际的函数

[SECTION .text]		; 目标文件中写了这些之后再写程序

_io_hlt:	; void io_hlt(void);
	HLT
	RET

_io_cli:
	CLI
	RET

_io_sti:
	STI
	RET

_io_stihlt:
	STI
	HLT
	RET

_io_in8:
	MOV		EDX, [ESP+4]	; port
	MOV		EAX, 0
	IN		AL, DX
	RET

_io_in16:
	MOV		EDX, [ESP+4]	; port
	MOV		EAX, 0
	IN		AX, DX
	RET

_io_in32:
	MOV		EDX, [ESP+4]	; port
	IN		EAX, DX
	RET

_io_out8:
	MOV		EDX, [ESP+4]
	MOV		AL, [ESP+8]
	OUT		DX, AL
	RET

_io_out16:
	MOV		EDX, [ESP+4]
	MOV		AL, [ESP+8]
	OUT		DX, AX
	RET

_io_out32:
	MOV		EDX, [ESP+4]
	MOV		AL, [ESP+8]
	OUT		DX, EAX
	RET
	
_io_load_eflags:
	PUSHFD					; 指的是push eflags
	POP		EAX
	RET

_io_store_eflags:
	MOV		EAX, [ESP+4]
	PUSH	EAX
	POPFD					; 指的是pop eflags
	RET

_load_gdtr:
	MOV		AX, [ESP + 4]
	MOV		[ESP + 6], AX
	LGDT	[ESP + 6]
	RET

_load_idtr:
	MOV		AX, [ESP + 4]
	MOV		[ESP + 6], AX
	LIDT 	[ESP + 6]
	RET
	
_load_cr0:
	MOV	EAX, CR0
	RET


	
_store_cr0:
	MOV 	EAX, [ESP + 4]
	MOV		CR0, EAX
	RET

_load_tr:					; void load_tr(int tr);
	LTR		[ESP + 4]		; tr
	RET
	
_asm_inthandler20:
	PUSH	ES
	PUSH	DS
	PUSHAD
	MOV		EAX,ESP
	PUSH	EAX
	MOV		AX,SS
	MOV		DS,AX
	MOV		ES,AX
	CALL	_inthandler20
	POP		EAX
	POPAD
	POP		DS
	POP		ES
	IRETD

_asm_inthandler21:
	PUSH	ES
	PUSH	DS
	PUSHAD
	MOV		EAX,ESP
	PUSH	EAX
	MOV		AX,SS
	MOV		DS,AX
	MOV		ES,AX
	CALL	_inthandler21
	POP		EAX
	POPAD
	POP		DS
	POP		ES
	IRETD

_asm_inthandler27:
	PUSH	ES
	PUSH	DS
	PUSHAD
	MOV		EAX,ESP
	PUSH	EAX
	MOV		AX,SS
	MOV		DS,AX
	MOV		ES,AX
	CALL	_inthandler27
	POP		EAX
	POPAD
	POP		DS
	POP		ES
	IRETD

_asm_inthandler2c:
	PUSH	ES
	PUSH	DS
	PUSHAD
	MOV		EAX,ESP
	PUSH	EAX
	MOV		AX,SS
	MOV		DS,AX
	MOV		ES,AX
	CALL	_inthandler2c
	POP		EAX
	POPAD
	POP		DS
	POP		ES
	IRETD
	
_memtest_sub:  			;unsigned int memtest_sub(unsigned int start, unsigned int end)
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	
	MOV		ESI, 0xaa55aa55
	MOV		EDI, 0x55aa55aa
	MOV		EAX, [ESP + 12 + 4]		;i = start;
	
mts_loop:
	MOV		EBX, EAX
	ADD		EBX, 0xffc				; p = i + 0xffc;
	MOV		EDX, [EBX]				; old = *port
	MOV		[EBX], ESI				; *p = pat0
	XOR		DWORD [EBX], 0xffffffff	; *p ^= 0xffffffff;
	CMP		EDI, [EBX]				; if (*p != pat1) goto fin;
	JNE		mts_fin
	XOR		DWORD [EBX], 0xffffffff	; *p ^= 0xffffffff;
	CMP		ESI, [EBX]				; if(*p != pat0) goto fin
	JNE		mts_fin
	MOV		[EBX], EDX				; *p = old
	ADD		EAX, 0x1000				; i += 0x1000;
	CMP		EAX, [ESP + 12 + 8]		; if (i <= end) goto mts_loop
	
	JBE		mts_loop
	POP		EBX
	POP		ESI
	POP		EDI
	RET
	
mts_fin:
	MOV		[EBX], EDX				; *p = old
	POP		EBX
	POP		ESI
	POP		EDI
	RET
	
_taskswitch4:						; void taskswitch4(void);
	JMP		4*8:0
	RET
	
_taskswitch3:						; void taskswitch3(void);
	JMP		3*8:0
	RET
	
_farjmp:							; void farjmp(int eip, int cs);
	JMP		FAR[ESP + 4]			; eip, cs
	RET
	
_farcall:							; void farcall(int eip, int cs);
	CALL	FAR[ESP + 4]			; eip, cs
	RET
	
_asm_cons_putchar:
	STI
	PUSH	1
	AND		EAX, 0xff				; 将AH和EAX的高位置0，将EAX置为已存入字符编码的状态
	PUSH	EAX
	PUSH	DWORD [0x0fec]			; 读取内存并push该值
	CALL	_cons_putchar
	ADD		ESP, 12					; 将栈中的数据丢弃
	IRETD