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

typedef enum logic [1:0] {
    READING,
    WAITING
} state_des;

state_des EA = WAITING;

always@(posedge clock_100KHz, posedge reset) begin
    if(reset) begin
        EA <= READING;
    end // if reset 
    else begin
        case(EA) 
            READING:begin
                if(write_in) begin 
                    EA <= WAITING;
                end else begin
                          EA <= READING;
                end
            end // READING 

            WAITING:begin   
                if(ack_in && status_out) begin
                    EA <= READING;
                end else begin
                        EA <= WAITING;
                end
            end // WAITING

        endcase

    end // else (if reset)
end // end FSM

logic count;

always@(posedge clock_100KHz, posedge reset) begin
        if(reset) begin
            data_out <= 0;
            data_ready <= 0;
            status_out <= 0;
            count <= 0;
        end // if reset
        else begin
            case(EA) 
                READING:begin
                    if(count < 8) begin
                        data_out[count] <= data_in;
                        count <= count + 1;
                    end        
                    else begin
                        data_ready <= 1;
                    end
                end // READING 

                WAITING:begin   
                    if(ack_in) begin
                        data_out <= 0;
                        data_ready <= 0;
                        count <= 0;
                    end
                end // WAITING
            endcase
        end // else (if reset)
end // end do clock

endmodule 