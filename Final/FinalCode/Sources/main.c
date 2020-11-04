#include <hidef.h>           /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include "main_asm.h"        /* interface to the assembly module */
#include "SendsChr.h"        /* interface to the SendsChr c-file module */


void main(void)
{	                                       
  int numberChars = 6;        // number of elements in the array
  char Data[6];              	/* Array of the values which will be sent to the speaker*/
  int dummy;
  
  SendInit();                	// initialize speaker via SPI port.
  Init_RTI();		              // initialize real time interrupt for note playing.
                                          
  Data[0]=250;                // initialize values to send to speaker(8-bit)
  Data[1]=180;	 
  Data[2]=150;	 
  Data[3]=120;	
  Data[4]=100;	 
  Data[5]=20;	 
 
  while (1)
  {
   	//push data (address) first 
   	//then push numberChars (value)
   	//then dummy is loaded into accumulator D
  	SendMessageInfo(Data,numberChars, dummy); 
  }
}	
