//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.11.01 (64-bit)
//Part Number: GW5AST-LV138PG484AC1/I0
//Device: GW5AST-138
//Device Version: B
//Created Time: Fri Apr  4 01:08:48 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_PLL_DDR3 your_instance_name(
        .lock(lock), //output lock
        .clkout0(clkout0), //output clkout0
        .clkout2(clkout2), //output clkout2
        .clkin(clkin), //input clkin
        .reset(reset), //input reset
        .enclk0(enclk0), //input enclk0
        .enclk2(enclk2) //input enclk2
    );

//--------Copy end-------------------
