module huffman_decoder (y, x, clk, reset);

input x, clk, reset;
output reg [2:0] y;


reg [2:0] state;

parameter STATE0 = 3'b000, STATE1 = 3'b001, STATE2 = 3'b010, STATE3 = 3'b011, STATE4 = 3'b100;

parameter Null = 3'b000, A = 3'b001, B = 3'b010, C = 3'b011, D = 3'b100, E = 3'b101, F = 3'b110;


always @ (posedge clk or posedge reset) begin
	if (reset == 1) begin
		state <= STATE0;
		assign y = Null;
	end
	else begin case (state)
		STATE0: if (x==1) begin
					assign y = Null;
					state <= STATE1; end
				else begin
					assign y = A;
					state <= STATE0; end
					
		STATE1: if (x==1) begin
					assign y = Null;
					state <= STATE3; end
				else begin
					assign y = Null;
					state <= STATE2; end

					
		STATE2: if (x==1) begin
					assign y = B;
					state <= STATE0; end
				else begin
					assign y = C;
					state <= STATE0; end


		STATE3: if (x==1) begin
					assign y = D;
					state <= STATE0; end
				else begin
					assign y = Null;
					state <= STATE4; end


		STATE4: if (x==1) begin
					assign y = E;
					state <= STATE0; end
				else begin
					assign y = F;
					state <= STATE0; end				
				
			endcase
		end
	end
endmodule