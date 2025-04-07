//********************************************************************
// <File>     : gw_ahb_ram.v
// <Author>   : GOWIN EMB
// <Function> : AHB RAM
// <Version>  : 1.2
// <Date>     : 2024
//********************************************************************

// gw_ahb_ram
module gw_ahb_ram #(
    parameter ADDR_WIDTH = 7,  // Address width, default is 7 bits
    parameter DATA_WIDTH = 16  // Data width, default is 16 bits
)(
    output  reg     [31:0]      AHB_HRDATA,
    output  wire                AHB_HREADYOUT,
    output  wire    [1:0]       AHB_HRESP,
    input   wire    [1:0]       AHB_HTRANS,
    input   wire    [2:0]       AHB_HBURST,
    input   wire    [3:0]       AHB_HPROT,
    input   wire    [2:0]       AHB_HSIZE,
    input   wire                AHB_HWRITE,
    input   wire    [31:0]      AHB_HADDR,
    input   wire    [31:0]      AHB_HWDATA,
    input   wire                AHB_HSEL,
    input   wire                AHB_HCLK,
    input   wire                AHB_HRESETn,
    
    // RAM 写端口操作
    input wire [ADDR_WIDTH-1:0] fpga_addr,           // ram 读地址
    output wire  [DATA_WIDTH-1:0] fpga_rd_data, 
    // RAM 写端口操作
    input wire [DATA_WIDTH-1:0] fpga_wr_data,
    input wire                  fpga_ce,
    input wire                  fpga_wren,
    input wire                  fpga_clk,
    input wire                  fpga_rst_n,
    
    output wire               [1:0] rv_state

);

wire    [1:0] fpga_state= {fpga_ce,fpga_wren};
reg     [1:0] rv_state_reg;


typedef enum reg [1:0] {  //定义状态机状态
    IDLE,
    RETRY_CYCLE1,
    RETRY_CYCLE2
} ahb_resp_state_t;

ahb_resp_state_t state, next_state;


reg ahb_hreadyout_reg;  //定义寄存器输出
reg [1:0] ahb_hresp_reg;


initial begin   //初始状态
    state = IDLE;
    ahb_hreadyout_reg = 1'b1;
    ahb_hresp_reg = 2'b00;
end


always @(posedge AHB_HCLK or negedge AHB_HRESETn) begin  //状态机逻辑
    if (!AHB_HRESETn) begin
        state <= IDLE;
        ahb_hreadyout_reg <= 1'b1;
        ahb_hresp_reg     <= 2'b00;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                ahb_hreadyout_reg <= 1'b1;  // 初始状态：准备好
                ahb_hresp_reg     <= 2'b00; // 默认 OKAY
            end
            RETRY_CYCLE1: begin
                ahb_hreadyout_reg <= 1'b0;  // 未准备好
                ahb_hresp_reg     <= 2'b01; // 第一个周期：RETRY
            end
            RETRY_CYCLE2: begin
                ahb_hreadyout_reg <= 1'b0;  // 未准备好
                ahb_hresp_reg     <= 2'b01; // 第二个周期：RETRY
            end
        endcase
    end
end


always @(*) begin  //状态转移逻辑
    next_state = state;
    case (state)
        IDLE: begin
            if (fpga_done_sync[1][1]) begin   //当 fpga_ce 有效时，进入第一个 RETRY 周期
                next_state = RETRY_CYCLE1;
            end
        end
        RETRY_CYCLE1: begin      //自动进入第二个周期
            next_state = RETRY_CYCLE2;
        end
        RETRY_CYCLE2: begin  //当 fpga_ce 无效时，返回 IDLE
            if (!fpga_done_sync[1][1]) begin
                next_state = IDLE;
            end else begin //如果 fpga_ce 仍有效，继续停留在第二个周期（可能需要多次重试）
                next_state = RETRY_CYCLE2;
            end
        end
    endcase
end


//reg ahb_hreadyout_reg   // 定义同步后的响应寄存器
//reg [1:0] ahb_hresp_reg;

//always @(posedge AHB_HCLK or negedge AHB_HRESETn) begin
//    if (!AHB_HRESETn) begin
//        ahb_hreadyout_reg <= 1'b1;  // 初始状态：准备好
//        ahb_hresp_reg     <= 2'b00; // 默认 OKAY
//    end else begin
//        if (fpga_done_sync[1][1]) begin           // 当 fpga_ce 有效时，设置为 RETRY（AHB_HRESP=01）
//            ahb_hreadyout_reg <= 1'b0; // 未准备好
//            ahb_hresp_reg     <= 2'b01; // RETRY
//        end else begin   // 否则，设置为 OKAY      
//            ahb_hreadyout_reg <= 1'b1; // 准备好
//            ahb_hresp_reg     <= 2'b00; // OKAY
//        end
//    end
//end


assign AHB_HREADYOUT = ahb_hreadyout_reg;// 将寄存器输出到端口
assign AHB_HRESP     = ahb_hresp_reg;


// Define Register for AHB BUS
reg [31:0]  ahb_address;
reg         ahb_control;
reg         ahb_sel;
reg         ahb_htrans;

reg [1:0] fpga_done_sync [1:0];

reg  ocea = 1'b1;
reg  oceb = 1'b1;

reg  [DATA_WIDTH-1:0]  din;
reg  [DATA_WIDTH-1:0]  dout;
reg  [5:0]             cmd;     // sel 2'b10 ,wrd 2'01
reg  [ADDR_WIDTH-1:0]  addr;

reg  sel;
reg  wrd;

wire [DATA_WIDTH-1:0]  d_out;

always @(posedge AHB_HCLK)
begin
    if(~AHB_HRESETn)
    begin
        ahb_address  <= 32'h0;
        ahb_control  <= 1'b0;
        ahb_sel      <= 1'b0;
        ahb_htrans   <= 1'b0;
    end
    else
    begin
        ahb_address  <= AHB_HADDR;
        ahb_control  <= AHB_HWRITE;
        ahb_sel      <= AHB_HSEL;
        ahb_htrans   <= AHB_HTRANS[1];
    end
end

wire write_enable = ahb_htrans & ahb_control    & ahb_sel;
wire read_enable  = ahb_htrans & (!ahb_control) & ahb_sel;

assign rv_state = rv_state_reg;

// Write data to AHB bus
always @(posedge AHB_HCLK)
begin
    if(~AHB_HRESETn)
    begin
        cmd[3:0]  <= 4'b0;
        addr <= 7'b0;
        din  <= 16'b0;
    end
    else if(ahb_control)
    begin
        case (ahb_address[15:0])
        16'h0000: cmd[3:0]  <= AHB_HWDATA[3:0];
        16'h0004: addr <= AHB_HWDATA[ADDR_WIDTH-1:0];
        16'h0008: din  <= AHB_HWDATA[DATA_WIDTH-1:0];
        endcase
    end
end

always @(posedge AHB_HCLK)
begin
    if(~AHB_HRESETn)
    begin
        sel <= 1'b0;
        wrd <= 1'b0;
    end
    else    // if(write_enable)
    begin
        sel <= cmd[1];
        wrd <= cmd[0];
    end
end

// Read data to AHB bus 
always @(posedge AHB_HCLK)
begin
    if(~AHB_HRESETn)
    begin
        dout <= 16'b0;
    end
    else
    begin
        dout <= d_out;
    end
end

// Register address
reg [31:0] ahb_rdata;

always @(*)
begin
    if(!ahb_control)  // Read cmd
    begin
        case (ahb_address[15:0])
        16'h0000:  ahb_rdata = cmd;		
        16'h0004:  ahb_rdata = addr;
        16'h0008:  ahb_rdata = din;
        16'h000C:  ahb_rdata = dout;
        default:   ahb_rdata = 32'hFFFFFFFF;
        endcase
    end
    else
    begin
        ahb_rdata = 32'hFFFFFFFF;
    end
end

always @(*) begin
    AHB_HRDATA = ahb_rdata;
end



always @(posedge AHB_HCLK or negedge AHB_HRESETn) begin
    if (!AHB_HRESETn) begin
        fpga_done_sync[1] <= 2'b0;        // 复位时清零
        fpga_done_sync[0] <= 2'b0;        // 复位时清零
    end
    else begin
        fpga_done_sync[0] <= fpga_state;  // 第一阶段：捕获异步信号
        fpga_done_sync[1] <= fpga_done_sync[0];    // 第二阶段：稳定信号
    end
end

always @(posedge AHB_HCLK or negedge AHB_HRESETn) begin
    if (!AHB_HRESETn) begin
        cmd [5:4] <= 2'b0;        // 复位时清零
    end
    else begin
        cmd [5:4] <= fpga_done_sync[1];
    end
end

always @(posedge AHB_HCLK ) begin
    if (!AHB_HRESETn) begin
        rv_state_reg <= 2'b0;        // 复位时清零
    end
    else begin
        rv_state_reg <= cmd [3:2];
    end
end
// Gowin_DPB instantiation
Gowin_DPB u_Gowin_DPB
(
    .douta(d_out),
    .doutb(fpga_rd_data),
    .clka(AHB_HCLK),
    .ocea(ocea),
    .cea(sel),
    .reseta(~AHB_HRESETn),
    .wrea(wrd),
    .clkb(fpga_clk),
    .oceb(oceb),
    .ceb(fpga_ce),
    .resetb(~fpga_rst_n),
    .wreb(fpga_wren),
    .ada(addr),
    .dina(din),
    .adb(fpga_addr),
    .dinb(fpga_wr_data)
);

endmodule