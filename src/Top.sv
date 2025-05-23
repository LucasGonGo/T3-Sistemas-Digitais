Module TOP{ // ligar os dois e gerar clocks
    input logic clock_1MHz // 1MHz = 10⁶
};

DESERIALIZADOR des{
    reset(),
    clock_100KHz(), // 100Khz = 100.10³
    write_in(),
    data_ready(),
    data_out(),
    ack_in(), // enable da fila, ativa quando termina de arrumar a fila
    status_out()
};

FILA queue{
    reset(),
    clock_10KHz(),   // 10khz = 10.10³
    data_in(),
    enqueue_in(),
    data_out(), 
    dequeue_in(),
    len_out()
};

always@(posedge clock_1MHz) begin
    
end // always do clock

// cria o ack do deserializador, usa o len_out como base, quando len_out++, ack = 1

endmodule