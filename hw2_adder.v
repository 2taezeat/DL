module cla_gen
# ( parameter W = 4 )
(   input signed [W-1:0] P,
    input signed [W-1:0] G,
    input C0,
    output signed [W:0] C
);
    assign C[0] = C0;
    
    genvar j;
    generate
        for (j = 0 ; j < W; j = j + 1)
        begin
            assign C[j+1] = G[j] | (P[j] & C[j]) ;
        end

    endgenerate
    
endmodule

module addsub_cla
# ( parameter W = 4 )
(   input signed [W-1:0] A,
    input signed [W-1:0] B,
    input M,
    output signed [W-1:0] S,
    output C,
    output V
);
    wire c0;
    assign c0 = M ? 1 : 0;
    
    wire signed [W-1:0] P_bus;
    wire signed [W-1:0] G_bus;
    wire signed [W:0] C_bus;

    genvar i;
    generate
        for (i = 0 ; i < W; i = i + 1)
        begin
                assign P_bus[i] = A[i] ^ (B[i] ^ M);
                assign G_bus[i] = A[i] & (B[i] ^ M);
        end     
    endgenerate

    cla_gen #(.W(W)) CLEGEN( .P( P_bus ), .G( G_bus ), .C0(c0), .C(C_bus) );

    genvar k;
    generate
        for (k = 0 ; k < W; k = k + 1)
        begin
                assign S[k] = P_bus[k] ^ C_bus[k];
        end     
    endgenerate

    assign V = C_bus[W] ^ C_bus[W-1];
    assign C = C_bus[W];
    
endmodule