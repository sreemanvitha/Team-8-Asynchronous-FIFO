vlib work

vlog async_fifo1_tb.sv
vlog fifomem.sv
vlog sync_w2r.sv
vlog sync_r2w.sv
vlog wptr_full.sv
vlog rptr_empty.sv
vlog async_fifo1_tb.sv

vsim -voptargs=+acc work.async_fifo1_tb

add wave -r *
run -all