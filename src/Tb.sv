`timescale 1ns/100ps
module tb #();

logic clk = 0;
logic rst;
logic data_in;
logic status;
logic [7:0] data_out;
logic write_in;
logic enqueue_in;
logic dequeue_in;


TOP dut(
    .clock_1MHz(clk), // 1MHz = 10⁶
    .rst(rst),
    .data_in(data_in),
    .write_in(write_in),
    .dequeue_in(dequeue_in),
    .enqueue_in(enqueue_in),
    .status_out(status),
    .data_out(data_out)
);

always begin
       #500; clk <= ~clk; // clock de 1 MHz, 50% duty cicle
   end

integer index;
integer words;
logic [0:7] send_data = 8'b10000000;
integer count_deque;


initial begin
   rst = 1;
   data_in = 0;
   write_in = 0;
   dequeue_in = 0;

    #2500;
    rst = 0;
    #4000;

    forever begin
        @(posedge status);
        #10000;
        for(words = 0; words < 8; words = words + 1)begin
            for(index = 0; index < 8; index = index + 1) begin

                data_in = send_data[index];
                write_in = 1;
                #10000;
                write_in = 0;
                #10000;
            end 
            #300000;
            send_data = send_data + 1;
        end    
         #300000;

         for(count_deque = 0; count_deque < 4; count_deque = count_deque + 1) begin
                dequeue_in = 1; 
              #200000;
                dequeue_in = 0; 
              #600000;
         end

    end
end    

 endmodule