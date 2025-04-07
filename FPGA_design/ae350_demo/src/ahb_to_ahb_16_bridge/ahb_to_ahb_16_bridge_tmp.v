//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.11.01 (64-bit)
//Part Number: GW5AST-LV138PG484AC1/I0
//Device: GW5AST-138
//Device Version: B
//Created Time: Sat Apr  5 20:09:02 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	AHB_to_AHB_16_Bridge_Top your_instance_name(
		.ds1_hsel(ds1_hsel), //output ds1_hsel
		.ds1_hrdata(ds1_hrdata), //input [31:0] ds1_hrdata
		.ds1_hreadyout(ds1_hreadyout), //input ds1_hreadyout
		.ds1_hresp(ds1_hresp), //input ds1_hresp
		.hclk(hclk), //input hclk
		.hresetn(hresetn), //input hresetn
		.us_haddr(us_haddr), //input [31:0] us_haddr
		.us_hsel(us_hsel), //input us_hsel
		.us_htrans(us_htrans), //input [1:0] us_htrans
		.us_hrdata(us_hrdata), //output [31:0] us_hrdata
		.us_hready(us_hready), //input us_hready
		.us_hreadyout(us_hreadyout), //output us_hreadyout
		.us_hresp(us_hresp), //output us_hresp
		.ds_hready(ds_hready) //output ds_hready
	);

//--------Copy end-------------------
