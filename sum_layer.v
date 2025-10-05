// In this layer we generate all the S bits from 0 to 15 
// and the Cout. We know that Si = Pi xor C(i-1).
// It turns out that Ci and G(i:0) at we are getting at the output
// of layer 8 at index i are equivalent. 

module sum_layer(P, C, P15, CIN, SUM, COUT);
    input [15:0] P, C;
    input CIN, P15;
    output [15:0] SUM;
    output COUT;

    assign SUM[0] = P[0] ^ CIN;       // S0 = P0 xor CIN

    genvar i;                         // For indices 1 to 15
    generate                          // Si = Pi xor C(i-1)
        for(i=1;i<16;i= i+1) begin : sum_loop  
            xor G1(SUM[i], P[i], C[i-1]);  // Si = Pi xor G(i-1:0)
        end
    endgenerate

    gray_cell inst(                  // Cout = G(15:0) + P(15:0)*CIN
        .G21(C[15]),
        .P21(P15),
        .G10(CIN),
        .G20(COUT)
    );
endmodule

