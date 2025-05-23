Module DESERIALIZADOR{
    input logic reset,
    input logic clock_100KHz, // 100Khz = 100.10³
    input bit data_in,
    input bit write_in,
    output bit data_ready,
    output reg[7:0] data_out,
    input  bit ack_in, // enable da fila, ativa quando termina de arrumar a fila
    output bit status_out
};

/*DESERIALIZADOR: Responsável por receber uma sequência de bits através do sinal
data_in e escrever palavras de 8 bits no sinal data_out. O sinal status_out indica se o
serializador está em condições de receber dados, enquanto o sinal write_in indica que o dado
deve ser interpretado pelo deserializador. O fio data_out possui 8 bits e representa a saída de
dados do deserializador. Os dados estão prontos para consumo quando o sinal data_ready
está alto. Para confirmar o dado recebido, o sinal ack_in precisa ser escrito.*/

always@(posedge clock_100KHz) begin
    if(write_in) // 
    if(status_out) begin // talvez isso seja no top
        data_in <= ;
    end
end // end do clock

endmodule 