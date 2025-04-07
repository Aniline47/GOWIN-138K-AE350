module key_wr_ram_test (
    input wire fpga_clk,     // FPGA 时钟信号
    input wire fpga_rst_n,   // FPGA 复位信号，低有效
    output reg [6:0] fpga_addr, // FPGA 地址输出
    output reg [15:0] fpga_wr_data, // FPGA 写数据输出
    output reg fpga_wren,    // FPGA 写使能信号
    output reg fpga_ce,      // FPGA 控制使能信号
    input wire key_in,       // 按键输入，按下为低电平
    output reg led,          // LED 输出，低电平点亮
    input wire wr_init,      // AE350上电之后再开始 
    input wire [1:0] rv_state // AE350状态 01为RV写入，需要重置write_done 
);

reg [1:0] rv_state_reg [1:0];


always @(posedge fpga_clk or negedge fpga_rst_n) begin
    if (!fpga_rst_n) begin
        rv_state_reg[1] <= 2'b0;        // 复位时清零
        rv_state_reg[0] <= 2'b0;        // 复位时清零
    end
    else begin
        rv_state_reg[0] <= rv_state;  // 第一阶段：捕获异步信号
        rv_state_reg[1] <= rv_state_reg[0];    // 第二阶段：稳定信号
    end
end

// 控制逻辑，处理按键和写入操作
reg [6:0] write_addr;
reg [3:0] write_count;
reg write_done;

always @(posedge fpga_clk or negedge fpga_rst_n) begin
    if (!fpga_rst_n) begin
        write_addr <= 7'd0;
        write_count <= 4'd0;
        write_done <= 1'b0;
        fpga_ce <= 1'b0;
        fpga_wren <= 1'b0;
        fpga_wr_data <= 16'd0;
        led <= 1'b1; // 默认熄灭
        fpga_addr <= 7'd0;
    end else if (rv_state_reg[1] == 2'b10) begin // 如果AE350处于RV写入状态，则重置写完成标志
        write_done <= 1'b0;
        led <= 1'b1; // 默认熄灭
        write_addr <= 7'd0;
    end else if (key_in == 1'b0 && !write_done && wr_init) begin // 检测到按键按下且未完成写入
        if (write_addr < 7'd100) begin
            fpga_ce <= 1'b1;
            fpga_wren <= 1'b1;
            fpga_wr_data <= {8'd0, write_addr}; // 写入地址作为数据
            fpga_addr <= write_addr;
            write_addr <= write_addr + 1'b1;
            write_count <= write_count + 1'b1;
            led <= 1'b1; 
        end else begin
            fpga_wren <= 1'b0;
            fpga_ce <= 1'b0;
            write_done <= 1'b1;
            led <= 1'b0; // 点亮LED
        end
    end else begin
        fpga_wren <= 1'b0;
        fpga_ce <= 1'b0;
    end
end

endmodule