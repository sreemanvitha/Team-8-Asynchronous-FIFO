vlib work

vlog design.sv
vlog testbench.sv

vsim -voptargs=+acc work.top

add wave -r *
run -all
