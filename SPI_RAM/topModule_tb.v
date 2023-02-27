module topModule_tb();
reg clk, rst_n, MOSI, SS_n;
//reg [7:0] tx_data;

//reg tx_valid;rx_valid,
wire MISO;
//wire [9:0] rx_data;

integer i;
initial begin
	clk = 0;
	forever #1 clk = ~clk;
end

initial begin 
	$readmemh("RAM.dat",DUT.RAM_interface.mem);
	rst_n = 0;
	#2;
	rst_n = 1;
	SS_n = 1;
	MOSI = 0;
	#2;
	SS_n = 0;
	//#2;
	//=====================================
	MOSI = 0;
	#2;
	MOSI = 0;
	#1;
	/*
	for(i=0;i<10;i=i+1) begin
		@(negedge clk)
		MOSI = $random;
	end
	*/
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#10;
	MOSI = 1;
	#2;
	MOSI = 0;
	//==================================
	#2;
	SS_n = 1;
	//MOSI = 1;
	//======================================== 
	// write specific data at adress 2;
	#2;
	SS_n = 0;
	MOSI = 0;
	#2;
	MOSI = 0;
	#2;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 1;
	#2;
	MOSI = 0;
	#7;
	MOSI = 0;
	#1;
	MOSI = 1;
	#2;
	MOSI = 1;
	#2;
	MOSI = 1;
	#2;
	MOSI = 0;
	#2;
	//=======================================
	/*
	SS_n = 1;
	#2;
	SS_n = 0;
	MOSI = 1;
	#2;

	MOSI = 1;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 1;
	#1;
	MOSI = 0;
	#2;
	*/
	//=========================
	SS_n = 1;
	#2;
	SS_n = 0;
	MOSI = 1;
	#2;

	MOSI = 1;
	#1;
	MOSI = 1;
	#3;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#9;
	MOSI = 0;
	#1;
	MOSI = 1;
	#2;
	MOSI = 0;
	#4;
	//read data from address 2
	SS_n = 1;
	#2;
	SS_n = 0;
	MOSI = 1;
	#2;

	MOSI = 1;
	#1;
	MOSI = 1;
	#5;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#1;
	MOSI = 0;
	#9;
	MOSI = 0;
	#1;
	MOSI = 1;
	#2;
	MOSI = 0;
	#40;
	$stop;
end
topModule DUT(clk,rst_n,SS_n,MOSI,MISO);
/*
SPI_Slave DUT1(MOSI, SS_n, tx_valid, tx_data, clk, rst_n, MISO, rx_valid, rx_data);
RAM_ #(.MEM_DEPTH(8)) DUT2(clk,rst_n,din,rx_valid,dout,tx_valid);
*/
endmodule

/*
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
	*/