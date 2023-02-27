module RAM_(clk,rst_n,din,rx_valid,dout,tx_valid);
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;
parameter DATA_WIDTH = 8;


input clk,rst_n,rx_valid;
input wire [9:0] din;

output reg [7:0] dout;
output reg tx_valid;
reg [DATA_WIDTH-1:0] mem [MEM_DEPTH-1:0];
reg [7:0] temp_address;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) 
		begin
			dout <= 'b0;
			tx_valid <= 0;
		end
	else begin
		case(din[9:8])
			'b00 : begin 
			if(rx_valid)
				temp_address <= din[7:0];
			tx_valid <= 0;
			end
			'b01 : begin 
			if(rx_valid)
				mem[temp_address] <= din[7:0];
			tx_valid <= 0; 
			end
			'b10 : begin
				temp_address <= din[7:0];
			end
			'b11 : begin
				 dout<= mem[temp_address]; 
				 tx_valid <= 1;
			end
		endcase
	end
end
endmodule
/*
if(~din[9]) begin
			 
		end 
		else begin

		end
*/