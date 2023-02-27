module RAM_tb();
reg clk,rst_n,rx_valid;
reg [9:0] din;
wire [7:0] dout;
wire tx_valid;

initial begin
	clk = 0;
	forever #1 clk = ~clk;
end
initial begin
	$readmemh("RAM.dat",DUT.mem);
	rst_n = 0;
	rx_valid = 0;
	din = 'b0;
	#2;
	rst_n = 1; 
	rx_valid = 1;
	din = 'b0000000010;
	#10;
	din = 'b0101101010;
	#10;
	din = 'b1000000010;
	#10;
	din = 'b1100000010;
	#10;
	$stop;
end
initial begin
	$monitor("din = %h , dout = %h , tx_valid = %b ,mem = %p",din , dout , tx_valid , DUT.mem);
end
RAM_ #(.MEM_DEPTH(8)) DUT(clk,rst_n,din,rx_valid,dout,tx_valid);
endmodule