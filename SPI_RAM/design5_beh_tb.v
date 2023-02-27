module count_tb();
reg clk,set,E;
wire [3:0] cnt;
initial begin
	clk = 0;
	forever #1 clk = ~clk;
end

initial begin
	set = 0;
	#2; //after one clk cycle
	set = 1;
	E =1;
	#30;
end
count_ DUT(,Eset,clk,cnt);
endmodule