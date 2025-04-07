// ae350_demo_top
module ae350_demo_top
(
    input CLK,
    input RSTN,
    // GPIO
    inout [2:0] LED,     // 2:0
    inout [2:0] KEY,     // 5:3
    //fpga
    input key_fpga,
    output led_fpga,
    //SPI
    inout SPI_CLK,
    inout SPI_CSN,
    inout SPI_MISO,
    inout SPI_MOSI,
    //I2C
    inout I2C_SCL,
    inout I2C_SDA,
    //TFT
    inout TFT_CLK,
    inout TFT_CSN,
    inout TFT_MISO,
    inout TFT_MOSI,
    inout TFT_RES,
    inout TFT_DC,
    inout TFT_BLK,
    // UART2
    output UART2_TXD,
    input  UART2_RXD,
    // SPI Flash Memory
    inout FLASH_SPI_CSN,
    inout FLASH_SPI_MISO,
    inout FLASH_SPI_MOSI,
    inout FLASH_SPI_CLK,
    inout FLASH_SPI_HOLDN,
    inout FLASH_SPI_WPN,
    // DDR3 Memory
    output DDR3_INIT,
    output [2:0] DDR3_BANK,
    output DDR3_CS_N,
    output DDR3_RAS_N,
    output DDR3_CAS_N,
    output DDR3_WE_N,
    output DDR3_CK,
    output DDR3_CK_N,
    output DDR3_CKE,
    output DDR3_RESET_N,
    output DDR3_ODT,
    output [13:0] DDR3_ADDR,
    output [1:0] DDR3_DM,
    inout [15:0] DDR3_DQ,
    inout [1:0] DDR3_DQS,
    inout [1:0] DDR3_DQS_N,
    // JTAG
    input TCK_IN,
    input TMS_IN,
    input TRST_IN,
    input TDI_IN,
    output TDO_OUT
);

parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 16;

wire CORE_CLK;
wire DDR_CLK;
wire AHB_CLK;
wire APB_CLK;
wire RTC_CLK;

wire DDR3_MEMORY_CLK;
wire DDR3_CLK_IN;
wire DDR3_LOCK;
wire DDR3_STOP;

wire [ADDR_WIDTH-1:0] internal_fpga_addr;
wire [DATA_WIDTH-1:0] internal_fpga_rd_data;
wire [DATA_WIDTH-1:0] internal_fpga_wr_data;
wire internal_fpga_wren;
wire internal_fpga_ce;
wire [1:0] rv_state;

// Gowin_PLL_AE350 instantiation
Gowin_PLL_AE350 u_Gowin_PLL_AE350
(
    .clkout0(DDR_CLK),          // 100MHz
    .clkout1(CORE_CLK),         // 800MHz
    .clkout2(AHB_CLK),          // 100MHz
    .clkout3(APB_CLK),          // 100MHz
    .clkout4(RTC_CLK),          // 10MHz
    .clkin(CLK),
    .enclk0(1'b1),
    .enclk1(1'b1),
    .enclk2(1'b1),
    .enclk3(1'b1),
    .enclk4(1'b1)
);


// Gowin_PLL_DDR3 instantiation
Gowin_PLL_DDR3 u_Gowin_PLL_DDR3
(
    .lock(DDR3_LOCK),
    .clkout0(DDR3_CLK_IN),          // 50MHz
    .clkout2(DDR3_MEMORY_CLK),      // 300MHz
    .clkin(CLK),
    .reset(1'b0),                   // Enforce
    .enclk0(1'b1),
    .enclk2(DDR3_STOP)
);


wire ae350_rstn;                    // AE350 power on and hardware reset in
wire ddr3_rstn;                     // DDR3 memory reset in
wire ddr3_init_completed;           // DDR3 memory initialized completed
wire key_ram;
assign DDR3_INIT = ~ddr3_init_completed;


// key_debounce instantiation
// DDR3 memory reset in key debounce
key_debounce u_key_debounce_ddr3
(
    .out(ddr3_rstn),
    .in(RSTN),
    .clk(CLK),      // 50MHz
    .rstn(1'b1)
);


// key_debounce instantiation
// AE350 power on and hardware reset in key debounce
key_debounce u_key_debounce_ae350
(
    .out(ae350_rstn),
    .in(ddr3_init_completed),
    .clk(CLK),      // 50MHz
    .rstn(1'b1)
);


wire [31:0] EXTS_HRDATA;
wire        EXTS_HREADYIN;
wire        EXTS_HRESP;
wire [31:0] EXTS_HADDR;
wire [2:0]  EXTS_HBURST;
wire [3:0]  EXTS_HPROT;
wire        EXTS_HSEL;
wire [2:0]  EXTS_HSIZE;
wire [1:0]  EXTS_HTRANS;
wire [31:0] EXTS_HWDATA;
wire        EXTS_HWRITE;
wire        EXTS_HCLK;
wire        EXTS_HRSTN;

wire        ds1_hsel;       // Slave 1
wire [31:0] ds1_hrdata;
wire        ds1_hreadyout;
wire        ds1_hresp;



// AHB_to_AHB_16_Bridge_Top instantiation
AHB_to_AHB_16_Bridge_Top u_AHB_to_AHB_16_Bridge_Top
(
    .ds1_hsel(ds1_hsel),            // Slave 1
    .ds1_hrdata(ds1_hrdata),
    .ds1_hreadyout(ds1_hreadyout),
    .ds1_hresp(ds1_hresp),
    .hclk(EXTS_HCLK),
    .hresetn(EXTS_HRSTN),
    .us_haddr(EXTS_HADDR),
    .us_hsel(EXTS_HSEL),
    .us_htrans(EXTS_HTRANS),
    .us_hrdata(EXTS_HRDATA),
    .us_hready(1'b1),
    .us_hreadyout(EXTS_HREADYIN),
    .us_hresp(EXTS_HRESP),
    .ds_hready()
);

key_debounce u_key_debounce_ram
(
    .out(key_ram),
    .in(key_fpga),
    .clk(CLK),      // 50MHz
    .rstn(1'b1)
);

key_wr_ram_test u_key_wr_ram_test (
    .fpga_clk(CLK),
    .fpga_rst_n(RSTN),
    .fpga_addr(internal_fpga_addr),
    .fpga_wr_data(internal_fpga_wr_data),
    .fpga_wren(internal_fpga_wren),
    .fpga_ce(internal_fpga_ce),
    .key_in(key_ram),
    .led(led_fpga),
    .wr_init(ddr3_init_completed),
    .rv_state(rv_state)
);
// gw_ahb_ram instantiation
// Slave 1: RAM1
gw_ahb_ram #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
) u_gw_ahb_ram_slave_1 (
	.AHB_HRDATA(ds1_hrdata),
	.AHB_HREADYOUT(ds1_hreadyout),
	.AHB_HRESP(ds1_hresp),
	.AHB_HTRANS(EXTS_HTRANS),
	.AHB_HBURST(EXTS_HBURST),
	.AHB_HPROT(EXTS_HPROT),
	.AHB_HSIZE(EXTS_HSIZE),
	.AHB_HWRITE(EXTS_HWRITE),
	.AHB_HADDR(EXTS_HADDR),
	.AHB_HWDATA(EXTS_HWDATA),
	.AHB_HSEL(ds1_hsel),
	.AHB_HCLK(EXTS_HCLK),
	.AHB_HRESETn(EXTS_HRSTN),
    .fpga_addr(internal_fpga_addr), // 连接到内部地址
    .fpga_rd_data(internal_fpga_rd_data), // FPGA 读数据输出
    .fpga_wr_data(internal_fpga_wr_data), // FPGA 写数据输入
    .fpga_ce(internal_fpga_ce), // FPGA 控制使能
    .fpga_wren(internal_fpga_wren), // FPGA 写使能
    .rv_state(rv_state), //RISC-V状态
    .fpga_clk(CLK),    // 使用系统时钟
    .fpga_rst_n(RSTN) // 使用复位信号
);


// RiscV_AE350_SOC_Top instantiation
RiscV_AE350_SOC_Top u_RiscV_AE350_SOC_Top
(
    .FLASH_SPI_CSN(FLASH_SPI_CSN),
    .FLASH_SPI_MISO(FLASH_SPI_MISO),
    .FLASH_SPI_MOSI(FLASH_SPI_MOSI),
    .FLASH_SPI_CLK(FLASH_SPI_CLK),
    .FLASH_SPI_HOLDN(FLASH_SPI_HOLDN),
    .FLASH_SPI_WPN(FLASH_SPI_WPN),
    .DDR3_MEMORY_CLK(DDR3_MEMORY_CLK),
    .DDR3_CLK_IN(DDR3_CLK_IN),
    .DDR3_RSTN(ddr3_rstn),              // DDR3 memory reset in, 0 is reset state
    .DDR3_LOCK(DDR3_LOCK),
    .DDR3_STOP(DDR3_STOP),
    .DDR3_INIT(ddr3_init_completed),    // DDR3 memory initialized completed
    .DDR3_BANK(DDR3_BANK),
    .DDR3_CS_N(DDR3_CS_N),
    .DDR3_RAS_N(DDR3_RAS_N),
    .DDR3_CAS_N(DDR3_CAS_N),
    .DDR3_WE_N(DDR3_WE_N),
    .DDR3_CK(DDR3_CK),
    .DDR3_CK_N(DDR3_CK_N),
    .DDR3_CKE(DDR3_CKE),
    .DDR3_RESET_N(DDR3_RESET_N),
    .DDR3_ODT(DDR3_ODT),
    .DDR3_ADDR(DDR3_ADDR),
    .DDR3_DM(DDR3_DM),
    .DDR3_DQ(DDR3_DQ),
    .DDR3_DQS(DDR3_DQS),
    .DDR3_DQS_N(DDR3_DQS_N),
    .TCK_IN(TCK_IN),
    .TMS_IN(TMS_IN),
    .TRST_IN(TRST_IN),
    .TDI_IN(TDI_IN),
    .TDO_OUT(TDO_OUT),
    .TDO_OE(),
    .EXTS_HRDATA(EXTS_HRDATA),
    .EXTS_HREADYIN(EXTS_HREADYIN),
    .EXTS_HRESP(EXTS_HRESP),
    .EXTS_HADDR(EXTS_HADDR),
    .EXTS_HBURST(EXTS_HBURST),
    .EXTS_HPROT(EXTS_HPROT),
    .EXTS_HSEL(EXTS_HSEL),
    .EXTS_HSIZE(EXTS_HSIZE),
    .EXTS_HTRANS(EXTS_HTRANS),
    .EXTS_HWDATA(EXTS_HWDATA),
    .EXTS_HWRITE(EXTS_HWRITE),
    .EXTS_HCLK(EXTS_HCLK),
    .EXTS_HRSTN(EXTS_HRSTN),

    .SPI_CLK(SPI_CLK), 
    .SPI_CSN(SPI_CSN), 
    .SPI_MISO(SPI_MOSI), 
    .SPI_MOSI(SPI_MISO), 
    .I2C_SCL(I2C_SCL), 
    .I2C_SDA(I2C_SDA), 

    .UART2_TXD(UART2_TXD),
    .UART2_RTSN(),
    .UART2_RXD(UART2_RXD),
    .UART2_CTSN(),
    .UART2_DCDN(),
    .UART2_DSRN(),
    .UART2_RIN(),
    .UART2_DTRN(),
    .UART2_OUT1N(),
    .UART2_OUT2N(),
    .GPIO({RAM_FPGA_DONE, TFT_RES, TFT_DC, TFT_BLK, TFT_CSN, TFT_CLK, TFT_MOSI, TFT_MISO, KEY, LED}),
    .CORE_CLK(CORE_CLK),
    .DDR_CLK(DDR_CLK),
    .AHB_CLK(AHB_CLK),
    .APB_CLK(APB_CLK),
    .RTC_CLK(RTC_CLK),
    .POR_RSTN(ae350_rstn),              // AE350 CPU core power on reset, 0 is reset state
    .HW_RSTN(ae350_rstn)                // AE350 hardware reset, 0 is reset state
);

endmodule