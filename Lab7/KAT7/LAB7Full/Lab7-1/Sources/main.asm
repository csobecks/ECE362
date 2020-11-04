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
            XDEF Entry, _Startup, main
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK     ; symbol defined by the linker for the end of the stack




; variable/data section
My_Variables:	SECTION
temp		ds.b	1
ton			ds.b	1
toff		ds.b	1
toffmem		ds.b	1
tonmem		ds.b	1

My_Constants: SECTION
; Insert here your data definition.
Port_U		equ		$268
Port_S		equ		$248
Port_T		equ		$240
Scans		dc.b	$70, $B0, $D0, $E0
LTable		dc.b	$eb, $77, $7b, $7d, $b7, $bb, $bd, $d7, $db, $dd, $e7, $ed, $7e, $be, $de, $ee
InTable		dc.b	$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $A, $B, $C, $D, $E, $F

; code section
MyCode:     SECTION
main:
_Startup:
Entry:
Starts:	     LDS	#__SEG_END_SSTACK
			 MOVB	#$FF, $24A
			 MOVB	#$F0, $26A
			 MOVB	#$F0, $26D
			 MOVB	#$0F, $26C
			 MOVB	#$FF, $242
			 BSET	Port_T,#%00010000
reset:		 LDX	#$0
loop1:		 LDAA	Scans, X
			 INX
			 CPX	#$5
			 BEQ	done
			 STAA	Port_U 
			 LDAA	Port_U
			 LDAB	Port_U
			 ANDB	#$0F
			 CMPB	#$0F
			 BEQ	loop1
			 LDAA	Port_U

			 JSR	Looking
			 BRA	loop1
			 
			 
Looking:	 	
			 LDY	#$0
loop:		 LDAB	LTable,Y
			 CPY	#$10
			 BEQ	loop1
			 CBA
			 BNE	nope
			 BEQ	Go
			 
			 
nope:		 INY
			 BRA	loop
			 
Go:			 LDAA	InTable,Y
			 STAA	ton
			 STAA	tonmem
			 LDAB	ton
			 LDAA	#15
			 SBA
			 STAA	toff
			 STAA	toffmem
			 LDAB	toff
check1:		 LDAA	ton
reel:		 CMPA	#0
			 BEQ	comp
			 BRA	sets
			 		
done:		 LDAA	tonmem
			 STAA	ton
			 LDAB	toffmem
			 STAB	toff
			 BRA	check1

check:		 LDAB	toff
comp:		 CMPB	#0
			 BEQ	reset
			 BRA	clears

sets:		 
			 BSET	Port_T, #$8
			 BRA	delay3
back2:		 LDAA	ton
			 DECA
			 STAA	ton
			 BRA	reel
			 
clears:		 BCLR	Port_T, #%00001000
			 BRA	delay2
			 LDAB	toff
back:		 DECB
			 STAB	toff
			 BRA	comp
			 			 
			 
delay2:		 LDY	#4000
actual:		 DEY
			 BNE   actual
			 BRA	back
			 
delay3:		 LDY	#4000
reall:		 DEY
			 BNE   reall
			 BRA	back2	