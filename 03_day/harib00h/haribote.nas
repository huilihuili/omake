; haribote-os
; TAB=4

; L?BOOT_INFO
CYLS	EQU		0x0ff0			; ?è??æ
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; ?°?FÚIM§B?FIÊ
SCRNX	EQU		0x0ff4			; ª¦X
SCRNY	EQU		0x0ff6			; ª¦Y
VRAM	EQU		0x0ff8			; ??tæI?nn¬

		ORG		0xc200			; ?¢öví?à¶IY?nû

		MOV		AL,0x13			; VGA ??C320*200*8ÊÊF
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; ??æÊÍ®
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; pBIOSæ¾??ãe?LEDw¦Ió?

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

fin:
		HLT
		JMP		fin
