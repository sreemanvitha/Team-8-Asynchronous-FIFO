vopt top -o top_optimized  +acc +cover=sbfec+async_fifo1(rtl).
vsim top_optimized -coverage
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save async_fifo1.ucdb
vcover report async_fifo1.ucdb 
vcover report async_fifo1.ucdb -cvg -details
