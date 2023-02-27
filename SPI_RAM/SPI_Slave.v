module SPI_Slave(MOSI, SS_n, tx_valid, tx_data, clk, rst_n, MISO, rx_valid, rx_data);
	parameter IDLE = 3'b000;
	parameter CHK_CMD = 3'b001;
	parameter READ_DATA = 3'b010;
	parameter READ_ADD = 3'b011;
	parameter WRITE = 3'b100;
	

	input wire clk, rst_n, MOSI, SS_n;
	input wire [7:0] tx_data;
	input wire tx_valid;
	output reg rx_valid;
	output reg [9:0] rx_data;
	output reg MISO;
	reg [2:0] c_state , next_state;
	reg rd_data_address;		// Internal signal to choose between READ_DATA & READ_ADD
	reg  Enable,set;
	wire [4:0] cnt;
	
	initial begin
		rd_data_address = 0;
	end
	// State memory
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			c_state <= IDLE;
			//rd_data_address <= 0;
		end
		else 
			c_state <= next_state;
	end

	

	// Next state (moore)
	always@(MOSI, SS_n, c_state,cnt) begin
		case (c_state)
			IDLE: begin
				if(~SS_n)
					next_state = CHK_CMD;
				else begin
					next_state = IDLE;
					Enable = 0;
				end
			end 
			CHK_CMD: begin
				//rd_data_address = 0;
				if(SS_n)
					next_state = IDLE;
				else begin
					if((~SS_n) && (~MOSI)) begin 
						next_state = WRITE;
						Enable = 1;
						end
					else if(((~SS_n) && (MOSI))) begin
						if((~rd_data_address)) begin 
							next_state = READ_ADD;
							//rd_data_address = ~rd_data_address;
							Enable = 1;
						end 
						else begin
							next_state = READ_DATA;
							//rd_data_address = ~rd_data_address;
							Enable=1;
						end
					end 
					/*else if((((~SS_n) && (MOSI)) && (rd_data_address))) begin
						
						end */
				end
			end 
			WRITE: begin 
				if(~(SS_n) && cnt <= 10) begin // < 10
					next_state = WRITE;
					//set = 0;
					end 
				else begin
					next_state = IDLE;
					Enable =0;
				end 
			end 
			READ_DATA: begin 
					if(~SS_n && cnt <= 10) begin
						next_state = READ_DATA;
						rd_data_address = 0;
					end
					else if(rx_data[9:8] == 'b11) begin
						next_state = READ_DATA;
					end
					/*
					else if(rx_data[9:8] == 'b11) begin 
						next_state = READ_MISO;
						Enable = 1;						
					end
					*/
					else begin
						next_state = IDLE;
						Enable = 0;
					end 
					end 
					/*
			READ_MISO : begin
				set = 1;
				if(cnt <= 10) begin
					next_state = READ_MISO;
				end
				else begin
					next_state = IDLE;
					Enable = 0;
				end
			end
			*/
			READ_ADD: begin 
				if(~(SS_n) && cnt <= 10) begin 
					next_state = READ_ADD;
					rd_data_address = 1;
				end 
				else begin 
					next_state = IDLE;
					Enable = 0;
					end 
				end 
			default:
					next_state = IDLE;
		endcase
	end


	// Output logic
	always @(posedge clk) begin
		case (c_state)
			IDLE: begin 
				rx_data <= 0;
				rx_valid <= 0;
				MISO <=0;
				//set <= 0;
				end 
			/*	
			CHK_CMD: begin 
				Enable <= 0;
				end 
			*/	
			WRITE : begin 
				//Enable <= 1;
				if(cnt-1 < 10) begin 
					{rx_data} <= {rx_data[8:0] ,MOSI};
				end 
				if(cnt == 10) begin
					rx_valid <= 1;  // data is ready to be recieved by RAM
					//set <= 0;
					//Enable <= 0; 
				end
			end 
			READ_ADD : begin

				if(cnt-1 < 10) begin 
					{rx_data} <= {rx_data[8:0] ,MOSI};
				end 
				if(cnt == 10) begin
					rx_valid <= 1;  // data is ready to be recieved by RAM
				end
			/*
			//if(tx_valid) begin
				MISO <= tx_data[cnt-1];
				if(cnt == 8)
					begin
						tx_valid <= 1;
						set <= 0;
						Enable <= 0;
					end
			//end
			*/
			end 
			READ_DATA : begin 
				if(cnt-1 < 10) begin 
					{rx_data} <= {rx_data[8:0] ,MOSI};
				end 
				if(tx_valid && cnt <20) 
					MISO <= tx_data[19-cnt];// 7-cnt and 10-cnt for spec. test bench
					/*
					if(cnt == 8)
						begin
							//tx_valid <= 1;
							set <= 0;
							Enable <= 0;
						end
						*/
				end 
			/*
			READ_MISO : begin
				if(tx_valid) 
					MISO <= tx_data[10-cnt];// 7-cnt and 10-cnt for spec. test bench
			end
			*/
		endcase 
	end
//assign MISO = (tx_valid) ? tx_data[10-cnt] : 0;
count_ countTOten(Enable,set,clk,cnt);
endmodule
