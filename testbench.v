`timescale 1ns / 1ps
module testbench;
reg clk = 1'b0;
reg start = 1'b0;
reg [7:0] tx_in;
wire tx_done;
wire [7:0] rx_out;
wire rx_done;
wire txrx; // data send at tx pin will be received by rx pin for verification of uart

uart dut(.clk(clk), .start(start), .tx_in(tx_in), .tx(txrx), .rx(txrx), .tx_done(tx_done), .rx_out(rx_out), .rx_done(rx_done));

integer i = 0;

initial begin
    start = 1;

    for (i = 0; i < 10; i = i + 1) begin // to generate 8 bit values for tx_in
        tx_in = 10 + ($random % 191);
        if(tx_in < 10 || tx_in > 200) begin
            tx_in = 10 + ((-$random) % 191);
        end
        @(posedge tx_done);
        @(posedge rx_done);
    end
    $finish;
end

initial begin
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("uart.vcd");
    $dumpvars(0, testbench);
    $monitor($time, " clk = %b, start = %b, tx_in = %8b, tx = %b, tx_done = %b, rx = %b, rx_out = %8b, rx_done = %b", clk, start, tx_in, txrx, tx_done, txrx, rx_out, rx_done);
end

endmodule







