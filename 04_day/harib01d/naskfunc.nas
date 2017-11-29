; naskfunc
; TAB=4

[FORMAT "WCOFF"]				; 制作目标文件的模式	
[BITS 32]						; 制作32位模式用的机械?言
[INSTRSET "i486p"]
[FILE "naskfunc.nas"]			; 源文件名信息


; 制作目?文件的信息



		GLOBAL	_io_hlt, _write_mem8			; 程序中包含的函数名


; 以下是??的函数

[SECTION .text]		; 目标文件中写了这些之后再写程序

_io_hlt:	; void io_hlt(void);
		HLT
		RET
		
_write_mem8:	; void write_mem8(int addr, int data)
		MOV		ECX, [ESP+4]
		MOV		AL, [ESP+8]
		MOV		[ECX], AL
		RET
