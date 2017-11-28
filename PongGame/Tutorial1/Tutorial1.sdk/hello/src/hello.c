/* Borrowed from ZynqBook Tutorials */

/* Include Files */
#include<stdio.h>
#include "xparameters.h"
#include "xgpio.h"
#include "xstatus.h"
#include "xbram.h"
#include "xil_printf.h"

/* Definitions */
#define GPIO_DEVICE_ID  XPAR_AXI_GPIO_0_DEVICE_ID	/* GPIO device that LEDs are connected to */
#define LED 0x03									/* Initial LED value - 00XX */
#define LED_DELAY 10000000							/* Software delay length */
#define LED_CHANNEL 1								/* GPIO port for LEDs */
#define printf xil_printf							/* smaller, optimized printf */

XGpio Gpio;											/* GPIO Device driver instance */
XGpio VGA;											/* VGA Device driver instance */

int Delay;
int BarRowStart,BarRowEnds, BarColStart, BarColEnds;
int BallRowStart,BallRowEnds, BallColStart, BallColEnds;
int button_data = 0;
int my=6;
int bx,by;

int ballColor = 0xF800;

int block1RowStart,block1RowEnds, block1ColStart, block1ColEnds;
int block2RowStart,block2RowEnds, block2ColStart, block2ColEnds;

void initComponent()
{
	BarRowStart = 270;
	BarRowEnds  = 280;
	BarColStart = 100;
	BarColEnds  = 170;

	BallRowStart = 260;
	BallRowEnds  = 269;
	BallColStart = 140;
	BallColEnds  = 150;

	block1RowStart=10;
	block1RowEnds=30;
	block1ColStart=30;
	block1ColEnds=50;


	block2RowStart=10;
	block2RowEnds=30;
	block2ColStart=60;
	block2ColEnds=80;

	my=6;
	bx=-5;
	by=-6;

}

void moveBar()
{
	if(button_data == 0b0001 && BarColEnds < 285)
	{
		BarColStart= BarColStart + my;
		BarColEnds= BarColEnds + my;
	}
	else if(button_data == 0b0010 && BarColStart > 10)
	{
		BarColStart= BarColStart - my;
		BarColEnds= BarColEnds - my;

	}

}



/* Main function. */
int main(void){


	int Status;
	initComponent();

	Status = XGpio_Initialize(&VGA, XPAR_VGA_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	XGpio_SetDataDirection(&VGA, 1, 0x00);


	Status = XGpio_Initialize(&Gpio, GPIO_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	XGpio_SetDataDirection(&Gpio, LED_CHANNEL, 0xF);

	//int led = 0x5;
	//XGpio_DiscreteWrite(&Gpio, 1, led);
	XGpio_DiscreteWrite(&VGA, 1, 0x07E0);






	XBram image;
	XBram_Config *imagecfg = XBram_LookupConfig(XPAR_AXI_BRAM_CTRL_0_DEVICE_ID);
	XBram_CfgInitialize(&image,imagecfg,XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR);

	while(1){

	button_data = XGpio_DiscreteRead(&Gpio, 1); //added late

	u32 *pixel = XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR;

	// window size 500*500;
	u32 startAddress = (u32) pixel;
	int i;
	//int flag=1;
	(*pixel) = 0x07C0; //red
	pixel++;
	for(i=1;i<100000;i++) {			//1FFFF
		//for(j=0;j<40;j++) {
			//(*pixel) = (i<<11)+(i<<6)+(i);
		u32 currentAddress= (u32)pixel;
		int dispAddress = currentAddress - startAddress;
		int divResult = dispAddress /300;  //row
		int divReminder = dispAddress % 300; // column
		if(currentAddress < (startAddress+90000))
			{


			//draw the Baar
			if((divReminder>BarColStart &&  divReminder<BarColEnds) && (divResult>BarRowStart && divResult <BarRowEnds))
			{

								(*pixel) = 0xFFFF;

			}
			//draw the Ball
			else if((divReminder>BallColStart &&  divReminder<BallColEnds) && (divResult>BallRowStart && divResult < BallRowEnds))
			{

								(*pixel) = ballColor;

			}
//			else if((divReminder>block1ColStart &&  divReminder<block1ColEnds) && (divResult>block1RowStart && divResult < block1RowEnds))
//			{
//
//								(*pixel) = 0xF8F0;
//
//			}
//			else if((divReminder>block2ColStart &&  divReminder<block2ColEnds) && (divResult>block2RowStart && divResult < block2RowEnds))
//			{
//
//								(*pixel) = 0xF80F;
//
//			}
			else{
				(*pixel) = 0x001F; // blue
				}

			}

//		else
//		{							//Does not work
//			(*pixel) = 0x0FF0;
//		}
		pixel++;



	}


	moveBar();

	for (Delay = 0; Delay < 1000000; Delay++);

	BallRowStart= BallRowStart + bx;
	BallRowEnds= BallRowEnds + bx;

	BallColStart= BallColStart + by;
	BallColEnds= BallColEnds + by;


	if(BallRowEnds>270)
	{
		if(BallColEnds>BarColStart && BallColStart <BarColEnds)
		bx= -bx;
		else{
				BallRowStart = 120;
				BallRowEnds  = 129;
				BallColStart = 140;
				BallColEnds  = 150;
				bx= -bx;
				by=-by;
				ballColor =~ballColor;

		}
	}




	else if(BallColEnds > 290 || BallColStart < 10 )
	{
		by= -by;

	}
	else if(BallRowEnds > 290 || BallRowStart < 10 )
	{
		bx= -bx;

	}




	}










	return 0;
}
