	     INCLUDE 'derivative.inc'
	   XDEF		WALL_CLOCK
	   XREF		Second, Count
	   

My_Code:		SECTION
main:
_Startup:
Entry:


WALL_CLOCK:	LDX		Count
			INX		
			STX		Count
			CPX		#1000
			BNE		exitISR
			LDX		#0
			STX		Count
			INC		Second
			LDAA	Second
			CMPA	#60
			BNE		exitISR
			LDAA	#0
			STAA	Second
exitISR:	BSET	CRGFLG,$80
			RTI