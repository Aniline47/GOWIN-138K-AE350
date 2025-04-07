//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.11.01 (64-bit)
//Part Number: GW5AST-LV138PG484AC1/I0
//Device: GW5AST-138
//Device Version: B
//Created Time: Fri Apr  4 01:14:35 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	RiscV_AE350_SOC_Top your_instance_name(
		.FLASH_SPI_CSN(FLASH_SPI_CSN), //inout FLASH_SPI_CSN
		.FLASH_SPI_MISO(FLASH_SPI_MISO), //inout FLASH_SPI_MISO
		.FLASH_SPI_MOSI(FLASH_SPI_MOSI), //inout FLASH_SPI_MOSI
		.FLASH_SPI_CLK(FLASH_SPI_CLK), //inout FLASH_SPI_CLK
		.FLASH_SPI_HOLDN(FLASH_SPI_HOLDN), //inout FLASH_SPI_HOLDN
		.FLASH_SPI_WPN(FLASH_SPI_WPN), //inout FLASH_SPI_WPN
		.DDR3_MEMORY_CLK(DDR3_MEMORY_CLK), //input DDR3_MEMORY_CLK
		.DDR3_CLK_IN(DDR3_CLK_IN), //input DDR3_CLK_IN
		.DDR3_RSTN(DDR3_RSTN), //input DDR3_RSTN
		.DDR3_LOCK(DDR3_LOCK), //input DDR3_LOCK
		.DDR3_STOP(DDR3_STOP), //output DDR3_STOP
		.DDR3_INIT(DDR3_INIT), //output DDR3_INIT
		.DDR3_BANK(DDR3_BANK), //output [2:0] DDR3_BANK
		.DDR3_CS_N(DDR3_CS_N), //output DDR3_CS_N
		.DDR3_RAS_N(DDR3_RAS_N), //output DDR3_RAS_N
		.DDR3_CAS_N(DDR3_CAS_N), //output DDR3_CAS_N
		.DDR3_WE_N(DDR3_WE_N), //output DDR3_WE_N
		.DDR3_CK(DDR3_CK), //output DDR3_CK
		.DDR3_CK_N(DDR3_CK_N), //output DDR3_CK_N
		.DDR3_CKE(DDR3_CKE), //output DDR3_CKE
		.DDR3_RESET_N(DDR3_RESET_N), //output DDR3_RESET_N
		.DDR3_ODT(DDR3_ODT), //output DDR3_ODT
		.DDR3_ADDR(DDR3_ADDR), //output [13:0] DDR3_ADDR
		.DDR3_DM(DDR3_DM), //output [1:0] DDR3_DM
		.DDR3_DQ(DDR3_DQ), //inout [15:0] DDR3_DQ
		.DDR3_DQS(DDR3_DQS), //inout [1:0] DDR3_DQS
		.DDR3_DQS_N(DDR3_DQS_N), //inout [1:0] DDR3_DQS_N
		.TCK_IN(TCK_IN), //input TCK_IN
		.TMS_IN(TMS_IN), //input TMS_IN
		.TRST_IN(TRST_IN), //input TRST_IN
		.TDI_IN(TDI_IN), //input TDI_IN
		.TDO_OUT(TDO_OUT), //output TDO_OUT
		.TDO_OE(TDO_OE), //output TDO_OE
		.EXTS_HRDATA(EXTS_HRDATA), //input [31:0] EXTS_HRDATA
		.EXTS_HREADYIN(EXTS_HREADYIN), //input EXTS_HREADYIN
		.EXTS_HRESP(EXTS_HRESP), //input EXTS_HRESP
		.EXTS_HADDR(EXTS_HADDR), //output [31:0] EXTS_HADDR
		.EXTS_HBURST(EXTS_HBURST), //output [2:0] EXTS_HBURST
		.EXTS_HPROT(EXTS_HPROT), //output [3:0] EXTS_HPROT
		.EXTS_HSEL(EXTS_HSEL), //output EXTS_HSEL
		.EXTS_HSIZE(EXTS_HSIZE), //output [2:0] EXTS_HSIZE
		.EXTS_HTRANS(EXTS_HTRANS), //output [1:0] EXTS_HTRANS
		.EXTS_HWDATA(EXTS_HWDATA), //output [31:0] EXTS_HWDATA
		.EXTS_HWRITE(EXTS_HWRITE), //output EXTS_HWRITE
		.EXTS_HCLK(EXTS_HCLK), //output EXTS_HCLK
		.EXTS_HRSTN(EXTS_HRSTN), //output EXTS_HRSTN
		.SPI_HOLDN(SPI_HOLDN), //inout SPI_HOLDN
		.SPI_WPN(SPI_WPN), //inout SPI_WPN
		.SPI_CLK(SPI_CLK), //inout SPI_CLK
		.SPI_CSN(SPI_CSN), //inout SPI_CSN
		.SPI_MISO(SPI_MISO), //inout SPI_MISO
		.SPI_MOSI(SPI_MOSI), //inout SPI_MOSI
		.I2C_SCL(I2C_SCL), //inout I2C_SCL
		.I2C_SDA(I2C_SDA), //inout I2C_SDA
		.UART2_TXD(UART2_TXD), //output UART2_TXD
		.UART2_RTSN(UART2_RTSN), //output UART2_RTSN
		.UART2_RXD(UART2_RXD), //input UART2_RXD
		.UART2_CTSN(UART2_CTSN), //input UART2_CTSN
		.UART2_DCDN(UART2_DCDN), //input UART2_DCDN
		.UART2_DSRN(UART2_DSRN), //input UART2_DSRN
		.UART2_RIN(UART2_RIN), //input UART2_RIN
		.UART2_DTRN(UART2_DTRN), //output UART2_DTRN
		.UART2_OUT1N(UART2_OUT1N), //output UART2_OUT1N
		.UART2_OUT2N(UART2_OUT2N), //output UART2_OUT2N
		.GPIO(GPIO), //inout [31:0] GPIO
		.CORE_CLK(CORE_CLK), //input CORE_CLK
		.DDR_CLK(DDR_CLK), //input DDR_CLK
		.AHB_CLK(AHB_CLK), //input AHB_CLK
		.APB_CLK(APB_CLK), //input APB_CLK
		.RTC_CLK(RTC_CLK), //input RTC_CLK
		.POR_RSTN(POR_RSTN), //input POR_RSTN
		.HW_RSTN(HW_RSTN) //input HW_RSTN
	);

//--------Copy end-------------------
