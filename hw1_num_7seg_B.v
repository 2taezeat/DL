module num_7seg_B(out,w,x,y,z);

input w;
input x;
input y;
input z;
output out;


wire w;
wire x;
wire y;
wire z;

assign out = (w) | (x & ~z)  | (x & ~y) | (~y & ~z); 

endmodule