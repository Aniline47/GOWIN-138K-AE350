/*
 * ******************************************************************************************
 * File		: demo_ddr3.c
 * Author	: GowinSemicoductor
 * Chip		: AE350_SOC
 * Function	: Read/Write DDR3 demo
 * ******************************************************************************************
 */

/*
 ********************************************************************************************
 * This example program shows how to read and write DDR3 memory directly.
 *
 * Scenario:
 *
 * After initialized, the demo program will write some data into DDR3 memory directly.
 * Then, it will read these data from DDR3 memory directly, and compare the data.
 ********************************************************************************************
* */

// Includes ---------------------------------------------------------------------------------
#include "demo.h"

// If running read/write DDR3 demo
#if RUN_DEMO_DDR3

// *********** Includes *********** //
#include "uart.h"
#include "delay.h"
#include "platform.h"
#include <stdio.h>


// ********* Declarations ********* //
int ddr3_write(unsigned char* data, unsigned int waddr, unsigned int size);
int ddr3_read(unsigned char* data, unsigned int raddr, unsigned int size);


// ********** Definitions ********* //

// Write data into DDR3
int ddr3_write(unsigned char* data, unsigned int waddr, unsigned int size)
{
	for(;size != 0;size--)
	{
		*(volatile unsigned char*)(DDRMEM_BASE+waddr) = *data;
		waddr++;
		data++;
	}

	return 0;
}

// Read data from DDR3
int ddr3_read(unsigned char* data, unsigned int raddr, unsigned int size)
{
	for(;size != 0;size--)
	{
		*data = *(volatile unsigned char*)(DDRMEM_BASE+raddr);
		raddr++;
		data++;

	}

	return 0;
}


#define DATA_SIZE	50000
#define RW_ADDR		0x3200000	// 50MB

unsigned char wdata[DATA_SIZE] = {0};	// Write data
unsigned char rdata[DATA_SIZE] = {0};	// Read data

unsigned int flag = 0;


// Application entry function
int demo_ddr3(void)
{
	// Initializes UART2
	uart_init(115200);		// Baud rate is 38400

	printf("\r\nIt's a Read/Write DDR3 demo.\r\n\r\n");

	printf("Initializes...\r\n");
	for(unsigned int i = 0;i < DATA_SIZE;i++)
	{
		wdata[i] = i % 256;
	}

	// Write data into DDR3
	printf("\r\nWrite data into DDR3...\r\n");
	printf("Write address: 0x%X\r\n", RW_ADDR);
	printf("Write size   : %d\r\n", DATA_SIZE);
	ddr3_write(wdata, RW_ADDR, DATA_SIZE);

	simple_delay_ms(1000);

	// Read data from DDR3
	printf("\r\nRead data from DDR3...\r\n");
	printf("Read address: 0x%X\r\n", RW_ADDR);
	printf("Read size   : %d\r\n", DATA_SIZE);
	ddr3_read(rdata, RW_ADDR, DATA_SIZE);

	// Check
	printf("\r\nCheck...\r\n");
	for(unsigned int i = 0;i < DATA_SIZE;i++)
	{
		if(rdata[i] != wdata[i])
		{
			flag = 1;
			break;
		}
	}

	if(flag)
	{
		printf("FAIL.");
	}
	else
	{
		printf("PASS.");
	}

	return 0;
}

#endif	/* RUN_DEMO_DDR3 */
