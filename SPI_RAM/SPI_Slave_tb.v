module SPI_Slave_tb();
reg clk, rst_n, MOSI, SS_n;
reg [7:0] tx_data;

reg tx_valid;
wire rx_valid,MISO;
wire [9:0] rx_data;

integer i;
initial begin
	clk = 0;
	forever #1 clk = ~clk;
end

initial begin 
	rst_n = 0;
	#2;
	rst_n = 1;
	SS_n = 1;
	MOSI = 0;
	#2;
	SS_n = 0;
	#2;
	MOSI = 0;
	#4;
	for(i=0;i<10;i=i+1) begin
		@(negedge clk)
		MOSI = $random;
	end
	#2;
	MOSI = 1;
	#2;
	for(i=0;i<10;i=i+1) begin
		@(negedge clk)
		MOSI = $random;
	end
	#4;
	SS_n = 1;
	MOSI = 0;
	#2;
	MOSI = 1;
	SS_n = 0;
	#2;
	MOSI=1;
	#2;
	MOSI=1;
	#1;
	MOSI = 1;
	for(i=0;i<10;i=i+1) begin
		@(negedge clk)
		MOSI = $random;
	end
	#4;
	// test for parallel to serial data
	
	SS_n = 1;
	MOSI = 0;
	#2;
	MOSI = 1;
	SS_n = 0;
	#2;
	tx_data = 'b01010110;
	tx_valid = 0;
	#4;
	tx_valid = 1;
	#20;

	//===========================
	SS_n = 1;
	MOSI = 0;
	#2;
	//MOSI = 1;
	SS_n = 0;
	#2;
	MOSI = 1;
	#2;
	#1;
	MOSI = 1;
	#2;
	for(i=0;i<10;i=i+1) begin
		@(negedge clk)
		MOSI = $random;
	end
	#4;
	$stop;
end
SPI_Slave DUT(MOSI, SS_n, tx_valid, tx_data, clk, rst_n, MISO, rx_valid, rx_data);
endmodule