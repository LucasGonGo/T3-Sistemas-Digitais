Module FILA{ // 8 espaços de 8 bits
    intput logic reset;
    input clock_10KHz;   // 10khz = 10.10³
    input bit data_in;
    input bit enqueue_in;
    output bit data_out; 
    output bit dequeue_in;
    output reg[7:0] len_out;
};

/*FILA: Representa um container de tamanho limitado do tipo LIFO de 8 bits. Os elementos são
inseridos na fila através dos sinais data_in e enqueue_in. Para remover um elemento da fila,
o sinais data_out e dequeue_in deverão ser utilizados. O sinal len_out possui 8 bits
sempre indica o número de elementos da fila. Quando o sinal dequeue_in sobe, o primeiro
dado a ser retirado da pilha deve aparecer em data_out no ciclo subsequente se o número de
elementos (len_out) for maior que zero.*/

logic [7:0] p0, p1, p2, p3, p4, p5, p6, p7; // tenho que repensar

/*Quando o sinal dequeue_in sobe, o primeiro
dado a ser retirado da fila deve aparecer em data_out no ciclo subsequente se o número de
elementos (len_out) for maior que zero.*/

always @(posedge clock_10KHz) begin
    always@(posedge dequeue_in) begin
        if(len_out > 0) begin
            data_out <= p0; // recebe o primeiro a sair, topo da fila, não é assim crtz
        end // if do len_out
    end // always do dequeue_in
end // always do clock


endmodule