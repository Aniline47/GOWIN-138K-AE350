/*
 * ******************************************************************************************
 * File		: ram.c
 * Author	: GowinSemicoductor
 * Chip		: AE350_SOC
 * Function	: RAM definitions.
 * ******************************************************************************************
 */

// Includes ---------------------------------------------------------------------------------
#include "ram.h"


// Definitions ------------------------------------------------------------------------------

void setDataCmd(RAM_RegDef* RAMx, unsigned int cmd)
{
	RAMx->DCMD = cmd & DATACMD;
}

void setDataAddr(RAM_RegDef* RAMx, unsigned int addr)
{
	RAMx->DADDR = addr & DATAADDR;
}

void setDataIn(RAM_RegDef* RAMx, unsigned int din)
{
	RAMx->DIN  = din & DATAIN;
}

unsigned int getDataCmd(RAM_RegDef* RAMx)
{
	return RAMx->DCMD & DATACMD;
}

unsigned int getDataAddr(RAM_RegDef* RAMx)
{
	return RAMx->DADDR & DATAADDR;
}

unsigned int getDataIn(RAM_RegDef* RAMx)
{
	return RAMx->DIN & DATAIN;
}

unsigned int getDataOut(RAM_RegDef* RAMx)
{
	return RAMx->DOUT & DATAOUT;
}
