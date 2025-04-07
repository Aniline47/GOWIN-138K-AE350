/*
 * ******************************************************************************************
 * File		: main.c
 * Author 	: GowinSemicoductor
 * Chip		: AE350_SOC
 * Function	: Main functions
 * ******************************************************************************************
 */

// Includes ---------------------------------------------------------------------------------
#include "ram.h"
#include "uart.h"
#include "delay.h"
#include <stdio.h>
#include "demo.h"
#include "Driver_GPIO.h"

#if RUN_DEMO_RAM
// Definitions ------------------------------------------------------------------------------


extern AE350_DRIVER_GPIO Driver_GPIO;	// GPIO

#define	GPIO_INT_PRIORITY	1	// GPIO interrupt priority
// Key: GPIO_3-5
#define GPIO_USED_MASK	0x38	// SW1
// 定义 GPIO 引脚（使用 pin_num）
#define GPIO_SW1_PIN        3
#define GPIO_SW2_PIN        4
#define GPIO_SW3_PIN        5

uint8_t key1=0;
uint8_t key2=0;
uint8_t key3=0;

static void setup_gpio(void);

// GPIO callback
void gpio_callback(uint32_t event)
{
	AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;
	switch (event)
	{
		case AE350_GPIO_EVENT_PIN3:
			//SW1
			simple_delay_ms(50);
			if(GPIO_Dri->PinRead(GPIO_SW1_PIN)==0){
				printf("It's in SW1 interrupt.\r\n");
				key1=1;
			}
			break;
		case AE350_GPIO_EVENT_PIN4:
			//SW1
			simple_delay_ms(50);
			if(GPIO_Dri->PinRead(GPIO_SW2_PIN)==0){
				printf("It's in SW2 interrupt.\r\n");
				key2=1;
			}
			break;
		case AE350_GPIO_EVENT_PIN5:
			//SW1
			simple_delay_ms(50);
			if(GPIO_Dri->PinRead(GPIO_SW3_PIN)==0){
				printf("It's in SW3 interrupt.\r\n");
				key3=1;
			}
			break;
		default:
			break;
	}
}
// Setup GPIO
static void setup_gpio(void)
{
	AE350_DRIVER_GPIO *GPIO_Dri = &Driver_GPIO;

	// Initializes GPIO
	GPIO_Dri->Initialize(gpio_callback);

	// Set GPIO direction
	GPIO_Dri->SetDir(GPIO_USED_MASK, AE350_GPIO_DIR_INPUT);		// Key input

	// Set switches interrupt mode to negative edge and enable it
	GPIO_Dri->Control(AE350_GPIO_SET_INTR_NEGATIVE_EDGE | AE350_GPIO_INTR_ENABLE, GPIO_USED_MASK, 0, 0);

	// Set the interrupt level 1 for the GPIO
	HAL_INTERRUPT_SET_LEVEL(IRQ_GPIO_SOURCE, GPIO_INT_PRIORITY);

	// Enable interrupt GPIO source
	HAL_INTERRUPT_ENABLE(IRQ_GPIO_SOURCE);

	printf("Setup GPIO.\r\n");
}

// Application entry function
int demo_ram(void)
{
	//----------------------------------- 1 ------------------------------------------//

    char s[256];
	unsigned int c;
	int n;

	// Initializes UART
	uart_init(115200);		// Baud rate is 38400

	setup_gpio();

	printf("\r\nDemo scanf() PASS.\r\n");

    printf("\r\nIt's an AHB to AHB 16 Bridge (Slave 1 and Slave 2) demo.\r\n");
    printf("These are RAM1 and RAM2 demos.\r\n");

    printf("\r\n\r\n\r\n");
    printf("\r\n*************************************************************************\r\n");
    printf("*************************************************************************\r\n");
    printf("*************************************************************************\r\n");
    printf("\r\n\r\n\r\n");

    printf("\r\n- - - - - - - - - - - - - - - - - - - - - - - - - - - \r\n");
    printf("Slave 1: RAM1...\r\n");
    while(1){
		if(key1){
			for(int i = 0; i < 100; i++)
			{
				printf("\r\n- - - - - - - - - - - - - - - - - - - - - - - - - - - \r\n");
				printf("Loop %d\r\n", i);

				// Read data from RAM1
				printf("Read data from RAM1...\r\n");
				setDataCmd(DEV_RAM1, 0x06);		// Command: select and read
				setDataAddr(DEV_RAM1, i);		// Address
				printf("Address    : %d\r\n",getDataAddr(DEV_RAM1));
				printf("Data output: %d\r\n",getDataOut(DEV_RAM1));

				simple_delay_ms(10);

			}
			key1=0;
			setDataCmd(DEV_RAM1, 0x00);
		}else if(key2){
			for(int i = 0; i < 100; i++)
			{
				printf("\r\n- - - - - - - - - - - - - - - - - - - - - - - - - - - \r\n");
				printf("Loop %d\r\n", i);

				// Write data into RAM1
				printf("Write data into RAM1...\r\n");
				setDataCmd(DEV_RAM1, 0x0B);		// Command: select and write
				setDataAddr(DEV_RAM1, i);		// Address
				setDataIn(DEV_RAM1, 230+i);		// Data input
				simple_delay_ms(10);
			}
			key2=0;
			setDataCmd(DEV_RAM1, 0x00);
		}else if(key3){
			key3=0;
			printf("Cmd output: %x\r\n",getDataCmd(DEV_RAM1));
		}
    }


    return 0;
}
#endif /* RUN_DEMO_RAM */
