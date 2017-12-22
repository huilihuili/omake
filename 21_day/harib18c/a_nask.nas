[FORMAT "WCOFF"]				; 制作目标文件的模式	
[BITS 32]						; 制作32位模式用的机器语言
[INSTRSET "i486p"]				; 使用到486为止的指令
[FILE "a_nask.nas"]			; 源文件名信息


; 制作目标文件的信息



	GLOBAL	_api_putchar

	
; 以下是实际的函数

[SECTION .text]		; 目标文件中写了这些之后再写程序

_api_putchar:	; void api_putchar(int c);
	MOV		EDX, 1
	MOV		AL, [ESP + 4]	; c
	INT		0x40
	RET