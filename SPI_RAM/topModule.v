module topModule(clk,rst_n,SS_n,MOSI,MISO);
input wire clk,rst_n,SS_n,MOSI;
output wire MISO;

//internal wires
wire [9:0] din;
wire [7:0] dout;
wire rx_valid,tx_valid;

// instantiation of SPI module
SPI_Slave Slave(
				.clk(clk),
				.rst_n(rst_n),
				.MOSI(MOSI),
				.SS_n(SS_n),
				.tx_valid(tx_valid),
				.tx_data(dout),
				.MISO(MISO),
				.rx_valid(rx_valid),
				.rx_data(din)
				);
// instantiation of RAM
RAM_ #(.MEM_DEPTH(8)) RAM_interface(clk,rst_n,din,rx_valid,dout,tx_valid);

endmodule