vlib work
vlog topModule.v topModule_tb.v
vsim -voptargs=+acc work.topModule_tb
add wave *
add wave -position insertpoint  \
sim:/topModule_tb/DUT/din \
sim:/topModule_tb/DUT/dout \
sim:/topModule_tb/DUT/rx_valid \
sim:/topModule_tb/DUT/tx_valid
add wave -position insertpoint  \
sim:/topModule_tb/DUT/Slave/c_state \
sim:/topModule_tb/DUT/Slave/next_state \
sim:/topModule_tb/DUT/Slave/rd_data_address \
sim:/topModule_tb/DUT/Slave/Enable \
sim:/topModule_tb/DUT/Slave/cnt
add wave -position insertpoint  \
sim:/topModule_tb/DUT/RAM_interface/mem \
sim:/topModule_tb/DUT/RAM_interface/temp_address
run -all
#quit -sim