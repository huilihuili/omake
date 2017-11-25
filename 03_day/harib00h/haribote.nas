; haribote-os
; TAB=4

; 有?BOOT_INFO
CYLS	EQU		0x0ff0			; ?定??区
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; ?于?色数目的信息。?色的位数
SCRNX	EQU		0x0ff4			; 分辨率X
SCRNY	EQU		0x0ff6			; 分辨率Y
VRAM	EQU		0x0ff8			; ?像?冲区的?始地址

		ORG		0xc200			; ?个程序要被装?到内存的什?地方

		MOV		AL,0x13			; VGA ??，320*200*8位彩色
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; ??画面模式
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; 用BIOS取得??上各?LED指示灯的状?

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

fin:
		HLT
		JMP		fin
