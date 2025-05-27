`timescale 1ns/100ps

module tb #();

logic clk;
logic rst;
logic data_in;
logic status;
logic data_out;
logic write_in;
logic enqueue_in;
logic dequeue_in;


TOP dut{
    .clock_1MHz(clk), // 1MHz = 10⁶
    .rst(rst),
    .data_in(data_in),
    .write_in(write_in),
    .dequeue_in(dequeue_in),
    .enqueue_in(enqueue_in),
    .status_out(status),
    .data_out(data_out)
};

always #500 clk = ~clk; // 1MHz = 1us = 1000ns, muda o sinal na metade do periodo total (500ns).

initial begin
    always@(posedge clk) begin
        if(status_out) begin
            write_in = 1;
            data_in = data_in + 1;
        end else begin
            write_in = 0;
        end
    end
end


endmodule