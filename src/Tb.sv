`timescale 1ns/100ps

module tb();

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

// Clock 1MHz: período de 1us (1000ns)
always begin
    #500 clk <= ~clk; // 1 MHz clock: 500ns HIGH, 500ns LOW
end

integer index;
integer words;
logic [7:0] send_data;

task send_byte(input [7:0] byte);
    for(index = 0; index < 8; index = index + 1) begin
        data_in = byte[index];
        write_in = 1;
        #10000; // 10us
        write_in = 0;
        #10000;
    end
    enqueue_in = 1;
    #20000;
    enqueue_in = 0;
endtask

task dequeue_one();
    dequeue_in = 1;
    #20000;
    dequeue_in = 0;
endtask

initial begin
    // Inicialização
    rst = 1;
    data_in = 0;
    write_in = 0;
    dequeue_in = 0;
    enqueue_in = 0;
    send_data = 8'b10000000;

    // Reset por 2.5us
    #2500;
    rst = 0;
    #5000;

    // Teste 1: Enfileira 8 bytes (fila cheia)
    for (words = 0; words < 8; words++) begin
        wait(status); // espera estar pronto
        send_byte(send_data);
        send_data++;
        #100000; // intervalo entre mensagens
    end

    // Teste 2: Desenfileira todos
    for (words = 0; words < 8; words++) begin
        #100000;
        dequeue_one();
        #200000;
    end

    // Teste 3: Intercalar enfileira e desenfileira
    for (words = 0; words < 4; words++) begin
        send_byte(send_data);
        #50000;
        dequeue_one();
        send_data++;
        #100000;
    end

    $display("Testbench finalizado.");
    $finish;
end

endmodule
