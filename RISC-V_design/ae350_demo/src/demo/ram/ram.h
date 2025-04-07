/*
 * ******************************************************************************************
 * File		: ram.h
 * Author	: GowinSemicoductor
 * Chip		: AE350_SOC
 * Function	: RAM definitions.
 * ******************************************************************************************
 */

#ifndef __RAM_H__
#define __RAM_H__

// Includes ---------------------------------------------------------------------------------
#include "platform.h"


// Definitions ------------------------------------------------------------------------------

// Register definition
typedef struct
{
	__IO   unsigned int  DCMD;			/* Offset: 0x000 (port select) 	 [15:0] */
	__IO   unsigned int  DADDR;			/* Offset: 0x004 (write or read) [15:0] */
	__IO   unsigned int  DIN;			/* Offset: 0x008 (write only)    [15:0] */
	__I    unsigned int  DOUT;			/* Offset: 0x00C (ready only)    [15:0] */
} RAM_RegDef;


// RAM1
#define RAM1_BASE				_IO_(AHB_EXT_BASE + 0x800000)	// RAM1 address: slave 1
#define AE350_RAM1				((RAM_RegDef *) RAM1_BASE )		// RAM1 register definition
#define DEV_RAM1				AE350_RAM1						// Device RAM1

// RAM2
#define RAM2_BASE				_IO_(AHB_EXT_BASE + 0x1000000)	// RAM2 address: slave 2
#define AE350_RAM2				((RAM_RegDef *) RAM2_BASE )		// RAM2 register definition
#define DEV_RAM2				AE350_RAM2						// Device RAM2

// Bit definitions
#define DATACMD		   			((unsigned int) 0x0000003F)
#define DATAADDR	   			((unsigned int) 0x0000007F)
#define DATAIN				 	((unsigned int) 0x0000FFFF)
#define DATAOUT					((unsigned int) 0x0000FFFF)


// Declarations ----------------------------------------------------------------------------

void setDataCmd(RAM_RegDef* RAMx, unsigned int cmd);		// Set data command
unsigned int getDataCmd(RAM_RegDef* RAMx);					// Get data command

void setDataAddr(RAM_RegDef* RAMx, unsigned int addr);		// Set data address
unsigned int getDataAddr(RAM_RegDef* RAMx);					// Get data address

void setDataIn(RAM_RegDef* RAMx, unsigned int din);			// Set input data
unsigned int getDataIn(RAM_RegDef* RAMx);					// Get input data

unsigned int getDataOut(RAM_RegDef* RAMx);					// Get output data


#endif	/* __RAM_H__ */
