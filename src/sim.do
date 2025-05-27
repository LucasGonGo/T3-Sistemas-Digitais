if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

set TOP_ENTITY {work.tb}

vlog -work work TOP.sv
vlog -work work FILA.sv
vlog -work work DESERIALIZADOR.sv

vlog -work work tb.sv

vsim -voptargs=+acc ${TOP_ENTITY}

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run 100ns