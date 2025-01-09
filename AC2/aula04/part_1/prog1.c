// aula04/part_1/prog1

#include <detpic32.h>

int main(void){
    TRISCbits.TRISC14 = 0; // Configure port RC14 as output
    while(1){
    while(readCoreTimer() < (FREQ/4)) 
    	{ 
    	    // delay(500); // Wait 0.5s 
    	    resetCoreTimer();
    	    LATCbits.LATC14 = !LATCbits.LATC14; // Toggle RC14 port value 
    	} 
    }
    return 0;
}
