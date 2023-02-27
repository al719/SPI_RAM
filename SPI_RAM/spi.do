vlib work
vlog SPI_Slave.v SPI_Slave_tb.v
vsim -voptargs=+acc work.SPI_Slave_tb
add wave *
add wave -position insertpoint  \
sim:/SPI_Slave_tb/DUT/c_state \
sim:/SPI_Slave_tb/DUT/Enable \
sim:/SPI_Slave_tb/DUT/cnt
add wave -position insertpoint  \
sim:/SPI_Slave_tb/DUT/next_state
add wave -position insertpoint  \
sim:/SPI_Slave_tb/DUT/rd_data_address
run -all
#quit -sim