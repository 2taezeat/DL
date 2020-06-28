// Zero detector module
//
module zero_detector (
output [1:0] present_state,
output y,
input x,
input clock,
input reset
);


reg [1:0] state;
wire [1:0] n_s;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always @ (posedge clock, negedge reset) begin
	if (reset == 0) state <= S0;
	else state <= n_s; 
end
	
assign n_s[1] = ( state[1] | state[0] ) & (~x); 
assign n_s[0] = (~state[1]) & (~state[0]) & (~x); 


assign present_state = state; 
assign y = state[1] & ~state[0] ;


endmodule