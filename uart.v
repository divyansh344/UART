`timescale 1ns / 1ps
module uart(
    input clk,
    input start,
    input [7:0] tx_in,
    output reg tx,
    output tx_done,
    input rx,
    output [7:0] rx_out,
    output rx_done
);

parameter clk_frequency = 1000000; // 1 MHz clock
parameter baud_rate = 9600; // 9600 bits per second
parameter clk_count = clk_frequency / baud_rate ;

reg bit_done = 1'b0;
integer count = 0;

parameter idle = 0, send = 1, check = 2;
reg[1:0] state = idle;

// generating slower clk
always @ (posedge clk) begin
    if(state == idle) begin
        count <= 0;
    end

    else begin
        if(count == clk_count) begin
            count <= 0;
            bit_done <= 1'b1;
        end

        else begin
            count <= count + 1;
            bit_done <= 1'b0;
        end
    end
end

// TX logic

reg [9:0] tx_data;
integer bit_index = 0;

always @ (posedge clk) begin
    case (state)
    idle: begin
        tx <= 1'b1;
        tx_data <= 0;
        bit_index <= 0;

        if (start == 1'b1) begin
            tx_data <= {1'b1, tx_in, 1'b0};
            state <= send;
        end

        else begin
            state <= idle;
        end
    end

    send: begin
        tx <= tx_data[bit_index];
        state <= check;
    end

    check: begin
        if (bit_index <= 9) begin
            if (bit_done == 1'b1) begin
                state <= send;
                bit_index <= bit_index + 1;
            end
        end

        else begin
            state <= idle;
            bit_index <= 0;
        end

    end

    default: state <= idle;

    endcase
end

assign tx_done = ((bit_index == 9) && (bit_done == 1'b1));

// RX logic

integer r_count = 0;
integer r_index = 0;
reg [9:0] rx_data = 0;

parameter r_idle = 0, r_wait = 1, receive = 2;
reg[1:0] r_state;

always @ (posedge clk) begin
    case(r_state)
    r_idle: begin
        r_count <= 0;
        r_index <= 0;
        rx_data <= 0;

        if(rx == 1'b0) begin
            r_state <= r_wait;
        end

        else begin
            r_state <= r_idle;
        end
    end

    r_wait: begin
        if(r_count < clk_count / 2) begin
            r_count <= r_count + 1;
            r_state <= r_wait;
        end

        else begin
            r_count <= 0;
            r_state <= receive;
            rx_data <= {rx, rx_data[9:1]};
        end
    end

    receive: begin
        if (r_index <= 9) begin
            if(bit_done == 1'b1) begin
                r_index <= r_index + 1;
                r_state <= r_wait;
            end
        end

        else begin
            r_state <= r_idle;
            r_index <= 0;
        end
    end

    default: r_state <= r_idle;

    endcase
end

assign rx_out = rx_data[8:1];
assign rx_done = ((r_index == 9) && (bit_done == 1'b1));

endmodule












            

         
    



    


        

