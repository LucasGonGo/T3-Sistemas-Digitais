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

always #500 clk = ~clk; // 1MHz = 1us = 1000ns, muda o sinal na metade do periodo total (500ns).

    integer i;
    logic [7:0] send_data = 8'b10011001;

initial begin
    rst = 1;
    data_in = 0;
    write_in = 0;
    enqueue_in = 0;
    dequeue_in = 0;

    #2500;
    rst = 0;
    #4000;

    forever begin
        @(posedge status);
        #10000;
        for(i = 0; i<8; i = i+1) begin

            data_in = send_data[i];
            write_in = 1;
            #10000;
            write_in = 0;
            #10000;
        end
            #200000;
    end
end

endmodule