module sigdelay #(
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
)(
    // interface signals
    input   logic               clk,        
    input   logic               rst,        
    input   logic               en,              
    input   logic               wr,         
    input   logic               rd,         
    input   logic [D_WIDTH-1:0] offset,       
    input  logic [D_WIDTH-1:0]  wr_addr,
    output  logic [D_WIDTH-1:0] mic_signal,        
    output  logic [D_WIDTH-1:0] delayed_signal       
);

    logic   [A_WIDTH-1:0]       address;    // interconnect wire

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (offset),
    .count (address)
);

ram2ports micRam (
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (wr_addr),
    .rd_addr (offset),
    .din (mic_signal),
    .dout (delayed_signal)
);

endmodule
