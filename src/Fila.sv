module FILA( // 8 espaços de 8 bits
    input logic reset,
    input logic clock_10KHz,   // 10KHz = 10.10³
    input [7:0] data_in,
    input logic enqueue_in,
    input logic dequeue_in,
    output logic[7:0] data_out, 
    output logic[3:0] len_out
);

/*FILA: Representa um container de tamanho limitado do tipo LIFO de 8 bits. Os elementos são
inseridos na fila através dos sinais data_in e enqueue_in. Para remover um elemento da fila,
o sinais data_out e dequeue_in deverão ser utilizados. O sinal len_out possui 8 bits
sempre indica o número de elementos da fila. Quando o sinal dequeue_in sobe, o primeiro
dado a ser retirado da pilha deve aparecer em data_out no ciclo subsequente se o número de
elementos (len_out) for maior que zero.*/

typedef enum logic [1:0]{
    WAITING,
    ENQUEUE,
    DEQUEUE
} state_queue;

state_queue EA;

logic [7:0] queue [7:0];
logic done_dequeueing, done_queueing; // sinais que terminou o queue ou dequeue
logic [2:0] head_ptr; // aponta pro começo da fila
logic [2:0] tail_ptr; // aponta pro final da fila

/*Quando o sinal dequeue_in sobe, o primeiro
dado a ser retirado da fila deve aparecer em data_out no ciclo subsequente se o número de
elementos (len_out) for maior que zero.*/

always@(posedge clock_10KHz, posedge reset) begin
    if(reset) begin
        EA <= WAITING;
    end // if reset
    else begin
        case(EA) 
            WAITING:begin
                if(enqueue_in && !done_queueing) begin
                    EA <= ENQUEUE;
                end else if(dequeue_in && !done_dequeueing) begin
                    EA <= DEQUEUE;
                end else begin
                    EA <= WAITING;
                end
            end

            ENQUEUE:begin
                if(done_queueing) begin
                    EA <= WAITING;
                end else begin
                    EA <= ENQUEUE;
                end
            end
            DEQUEUE:begin
                if(done_dequeueing) begin
                    EA <= WAITING;
                end else begin
                    EA <= DEQUEUE;
                end 
            end
        endcase
    end // else (if reset)
end // always FSM

always@(posedge clock_10KHz, posedge reset) begin
    if(reset)begin
        head_ptr <= 0;
        tail_ptr <= 0;
        data_out <= 0;
        len_out <= 0;
    end // if reset
    else begin 
        case(EA)
            WAITING:begin
                done_dequeueing <= 0;
                done_queueing <= 0;
            end

            ENQUEUE:begin
                if(!done_queueing && len_out < 8) begin
                        queue[tail_ptr] <= data_in;
                        tail_ptr <= (tail_ptr == 3'd7) ? 0 : tail_ptr + 1; // garante que os ptr sempre estarão entre 0 e 7
                        len_out <= len_out + 1;
                        done_queueing <= 1;
                end
            end

            DEQUEUE:begin
                if(!done_dequeueing) begin
                    if(len_out > 0) 
                        begin 
                            data_out <= queue[head_ptr];
                            queue[head_ptr] <= 0; 
                            head_ptr <= (head_ptr + 1) % 8;
                            len_out <= len_out - 1;
                            done_dequeueing <= 1;
                        end else begin
                            data_out <= 0; // fila vazia
                            done_dequeueing <= 1;
                        end
                end
            end

    
        endcase
    end // else (if reset)
end // always


endmodule