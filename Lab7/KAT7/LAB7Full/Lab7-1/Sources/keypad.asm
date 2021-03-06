	XDEF	Keypad
	
	
My_Variables:	SECTION
temp		ds.b	1

My_Constants:	SECTION
Port_U		equ		$268
Port_S		equ		$248
Scans		dc.b	$70, $B0, $D0, $E0
LTable		dc.b	$eb, $77, $7b, $7d, $b7, $bb, $bd, $d7, $db, $dd, $e7, $ed, $7e, $be, $de, $ee
InTable		dc.b	$0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $A, $B, $C, $D, $E, $F

		
My_Code:	SECTION
Main:
_Startup:
Entry:	
 Keypad:	
Starts:	     MOVB	#$FF, $24A
			 MOVB	#$F0, $26A
			 MOVB	#$F0, $26D
			 MOVB	#$0F, $26C
reset:		 LDX	#$0
loop1:		 LDAA	Scans, X
			 INX
			 CPX	#$5
			 BEQ	PWM
			 STAA	Port_U
			 LDS	$C027
			 LDAA	Port_U
			 CMPA	#$0F
			 BEQ	loop1
			 LDAA	Port_U
			 LDS	$C037
			 JSR	Looking
			 BRA	loop1
			 
delay:	 	 LDY	#1000
			 DEY
			 BNE	delay
			 RTS
			 
Looking:	 	
			 LDY	#$0
loop:		 LDAB	LTable,Y
			 CPY	#$10
			 BEQ	done
			 CBA
			 BNE	nope
			 BEQ	Go
			 
nope:		 INY
			 BRA	loop
			 
Go:			 LDAA	InTable,Y
			 STAA	Port_S
			 BRA	done
			 		
done:		 BRA	loop1

PWM:		 RTS