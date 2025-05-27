# wave.do - script para visualizar sinais do testbench

# Limpa todas as ondas anteriores
delete wave *

# Adiciona os sinais principais
add wave -divider "Clock & Reset"
add wave -hex tb.clk
add wave -hex tb.rst

add wave -divider "Entradas"
add wave -hex tb.data_in
add wave -hex tb.write_in
add wave -hex tb.enqueue_in
add wave -hex tb.dequeue_in

add wave -divider "Saídas"
add wave -hex tb.status
add wave -hex tb.data_out

# Caso queira ver os sinais internos do DUT, descomente:
# add wave -recursive tb.dut

# Zoom para o início
run 0
wave zoom full
