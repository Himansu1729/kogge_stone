// This is the first layer of a Kogge-Stone adder
// Here we generate 16 bits of P and G, bit-by-bit
// correspinding to the 16 bits of A and B using pg_generator

// Pi = Ai xor Bi
// Gi = Ai and Bi

module layer_pg(A, B, P_OUT, G_OUT);
    input [15:0] A, B;
    output [15:0] P_OUT, G_OUT;
    
    genvar i; 
    generate  
        for(i=0;i<16;i=i+1) begin : pg_gen
            pg_gen inst(
                .A(A[i]),
                .B(B[i]),
                .P(P_OUT[i]),
                .G(G_OUT[i])
            );
        end
    endgenerate
endmodule


