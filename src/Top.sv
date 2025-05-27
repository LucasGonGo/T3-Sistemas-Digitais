Module TOP{ // ligar os dois e gerar clocks // ins e outs são para o tb!!!
    input logic clock_1MHz, // 1MHz = 10⁶
    input logic rst,
    input logic data_in,
    input logic write_in,
    input logic enqueue_in,
    input logic dequeue_in,
    output logic status_out,
    output logic data_out
};

logic link_data;
logic link_enable_data;
logic check_ack = 0;
logic len_out;

DESERIALIZADOR des{
    .reset(rst),
    .clock_100KHz(clk_100KHz), // 100Khz = 100.10³
    .data_in(data_in),
    .write_in(write_in),
    .data_ready(link_enable_data),
    .data_out(link_data),
    .ack_in(check_ack), // enable da fila, ativa quando termina de arrumar a fila
    .status_out(status_out)
};

FILA queue{
    .reset(rst),
    .clock_10KHz(clk_10KHz),   // 10khz = 10.10³
    .data_in(link_data),
    .enqueue_in(link_enable_data),
    .data_out(data_out), 
    .dequeue_in(dequeue_in),
    .len_out(len_out)
};


    // faz um clock de 100k e um de 10k com base em um de 1M
    // t = 1/f, f = 1Mhz e t = 1 μs, para termos 10k, temos que dividir o t por 100, então contamos até 50 (1/2 periodo) para trocarmos o sinal, já para 100k temos que dividir t por 10, então contamos até 5 (dnv, 1/2 do periodo).

    logic clk_100KHz, clk_10KHz; // passa os clks para os modulos deles
    logic [3:0] count_100KHz = 0; // count de 0 a 4
    logic [6:0] count_10KHz = 0;  // count de 0 a 49

    always_ff @(posedge clock_1MHz) begin
        if (rst) begin
            count_100kHz <= 0;
            count_10kHz  <= 0;
            clk_100kHz   <= 0;
            clk_10kHz    <= 0;
        end else begin
            if (count_100kHz == 4'd4) begin // conta de 0 a 4, então, quando for 4, muda o sinal do clk
                clk_100kHz <= ~clk_100kHz; // muda sinal
                count_100kHz <= 0;         // zera o count
            end else begin
                count_100kHz <= count_100kHz + 1; // count++
            end

            if (count_10kHz == 7'd49) begin  // conta de 0 a 49, então, quando for 49, muda o clk
                clk_10kHz <= ~clk_10kHz; // muda sinal
                count_10kHz <= 0;        // zera o count
            end else begin
                count_10kHz <= count_10kHz + 1; // count++
            end
        end
    end

    always@(len_out) begin
        check_ack <= ~check_ack;  // talvez?, acho que ele não zera
    end
    // cria o ack do deserializador, usa o len_out como base, quando len_out++, ack = 1

endmodule