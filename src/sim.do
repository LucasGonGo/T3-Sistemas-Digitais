if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

set TOP_ENTITY {work.tb}

vlog -work work Top.sv
vlog -work work Fila.sv
vlog -work work Deserializador.sv

vlog -work work Tb.sv

vsim -voptargs=+acc ${TOP_ENTITY}

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run 10ms