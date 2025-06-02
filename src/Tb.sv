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

// Clock 1MHz
always begin
    #500 clk <= ~clk; // período de 1us
end

integer index;
logic [0:7] send_data = 8'b10000000;
integer word_count = 0;

task send_byte(input [7:0] my_byte);
    for(index = 0; index < 8; index = index + 1) begin
        data_in = my_byte[index];
        write_in = 1;
        #10000; // 10us
        write_in = 0;
        #10000;
    end
    enqueue_in = 1;
    #20000;
    enqueue_in = 0;
endtask

initial begin
    // Inicialização
    rst = 1;
    data_in = 0;
    write_in = 0;
    dequeue_in = 0;
    enqueue_in = 0;

    #2500;
    rst = 0;
    #4000;

    // Parte 1: Preencher a fila completamente
    $display("Preenchendo a fila...");
    for (word_count = 0; word_count < 8; word_count++) begin
        @(posedge status); // Espera o deserializador estar pronto
        #10000;
        send_byte(send_data);
        send_data = send_data + 1;
        #200000; // Espera processamento
    end

    // Parte 2: Verifica se travou
    $display("Verificando se o status trava quando a fila está cheia...");
    #100000;
    if (status) begin
        $display("✅ Fila cheia e deserializador travado corretamente (status_out = 1).");
    end else begin
        $display("❌ ERRO: status_out = 0 mesmo com a fila cheia!");
    end

    // Parte 3: Tenta inserir mais um dado — não deve ser aceito
    @(posedge clk);
    send_byte(8'b11110000);
    $display("Tentativa de envio com fila cheia. (Deveria ser ignorado ou travar)");

    #200000;

    // Parte 4: Esvazia a fila parcialmente para validar recuperação
    $display("Esvaziando parcialmente a fila...");
    dequeue_in = 1; #200000;
    dequeue_in = 0; #100000;

    dequeue_in = 1; #200000;
    dequeue_in = 0; #100000;

    // Parte 5: Tenta inserir novamente (agora deve funcionar)
    @(posedge status);
    send_byte(8'b01010101);
    $display("Inserção após dequeues (deve funcionar)");

    #500000;
    $finish;
end

endmodule
