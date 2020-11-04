;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main, Second, Count
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, WALL_CLOCK      ; symbol defined by the linker for the end of the stack




; variable/data section
My_Variables: SECTION
Second		ds.b	1
Count		ds.w	1
My_Constants:	SECTION
Port_S		equ	$248
Port_S_D	equ	$24A
; Insert here your data definition.



; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            CLI                     ; enable interrupts
            
            MOVW	#0, Count
            MOVB	#$FF, Port_S_D
            MOVB	#$40, RTICTL
            CLR		Second
            MOVB	#$80, CRGINT
           	
 display:	LDAB	Second
 			LDAA	#0
 			LDX		#10
 			IDIV
 			TFR		X,A
 			LSLA
 			LSLA
 			LSLA
 			LSLA
 			ABA
 			STAA	Port_S
 			BRA		display	
