module count_(Enable,set,clk,cnt);
input wire set,clk,Enable;
output reg [4:0] cnt;
always @(posedge clk or negedge set) begin
	if (~set) 
		 cnt <= 'b0;
	else begin
	if(~Enable)
		cnt <= 'b0;
	else 
		cnt <= cnt+1;
end		
end
endmodule