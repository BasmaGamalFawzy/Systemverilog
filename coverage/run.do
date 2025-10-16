# do file for questa
vlib work
vmap work work
vlog testbench.sv # edit it to your testbench
vsim -voptargs=+acc work.top  ;# or your top-level module
run -all
coverage save fcover.ucdb  ;# UCDB format in Questa
coverage report -details -verbose -output cov.txt
exit

# vlog expxx.sv 
# vsim work.top -batch -do "  run -all; coverage save fcover.ucdb  ; coverage report -details -verbose -output cov.txt;exit"
vsim work.top -batch -do "  run -all; coverage save fcover.ucdb  ; coverage report -verbose -output cov.txt;exit"