Module TOP{ // ligar os dois e gerar clocks
    input logic clock_1MHz; // 1MHz = 10⁶
}

DESERIALIZADOR des{

}

FILA queue{

}

always@(posedge clock_1MHz) begin
    
end // always do clock

// cria o ack do deserializador, usa o len_out como base, quando len_out++, ack = 1

endmodule