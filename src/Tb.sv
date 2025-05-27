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

        #2000;
        rst = 0;

        #5000;

        for (int i = 0; i < 8; i++) begin // manda de 0 a 7 esperando o status_out ficar alto
            wait (status == 1);   
            write_in = 1;
            data_in = i[0];       
            #1000;                
            write_in = 0;
            #1000;
        end
        
        #10000;

        dequeue_in = 1; // manda retirar da fila
        #1000;
        dequeue_in = 0;

        #10000;

        $finish;
    end

endmodule