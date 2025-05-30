`timescale 1ns/100ps

module tb #();

logic clk;
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

initial begin
        clk = 0;
        rst = 1;
        data_in = 0;
        write_in = 0;
        enqueue_in = 0;
        dequeue_in = 0;

        #2500;
        rst = 0;
        #4000;
        // manda de 0 a 7 esperando o status_out ficar alto
        write_in = 1;
        data_in = 1; // vai alternando entre 0 e 1, escreve 8 vezes      
        #2500;                
        data_in = 0;
        #2500;
        data_in = 1;
        #2500;
        data_in = 1; // vai alternando entre 0 e 1, escreve 8 vezes      
        #2500;                
        data_in = 0;
        #2500;
        data_in = 1;
        #2500;
        data_in = 1; // vai alternando entre 0 e 1, escreve 8 vezes      
        #2500;                
        data_in = 0;
        #2500;
        write_in = 0;
    
    end

endmodule