  INCLUDE 'derivative.inc'
XDEF  	Keypad
XREF    Scans, done, LTable, nope, Go

My_Code:	SECTION
main:
_Startup:
Entry:

Keypad:		 
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