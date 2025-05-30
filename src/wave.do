onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Clock & Reset}
add wave -noupdate -radix hexadecimal /tb/clk
add wave -noupdate /tb/dut/des/clock_100KHz
add wave -noupdate /tb/dut/clk_10KHz
add wave -noupdate -radix hexadecimal /tb/rst
add wave -noupdate -divider Entradas
add wave -noupdate -radix hexadecimal /tb/data_in
add wave -noupdate /tb/dut/des/data_in
add wave -noupdate -radix hexadecimal /tb/write_in
add wave -noupdate /tb/dut/des/write_in
add wave -noupdate -radix hexadecimal /tb/enqueue_in
add wave -noupdate -radix hexadecimal /tb/dequeue_in
add wave -noupdate -divider SaÃ­das
add wave -noupdate -radix hexadecimal /tb/status
add wave -noupdate -radix hexadecimal /tb/data_out
add wave -noupdate /tb/dut/des/data_out
add wave -noupdate /tb/dut/des/status_out
add wave -noupdate /tb/dut/des/EA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {48618200 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {10656 ns}
