module sum_layer(P, C, P15, CIN, SUM, COUT);
    input [15:0] P, C;
    input CIN, P15;
    output [15:0] SUM;
    output COUT;

    assign SUM[0] = P[0] ^ CIN;

    genvar i;
    generate 
        for(i=1;i<16;i= i+1) begin : sum_loop
            xor G1(SUM[i], P[i], C[i-1]);
        end
    endgenerate

    gray_cell inst(
        .G21(C[15]),
        .P21(P15),
        .G10(CIN),
        .G20(COUT)
    );
endmodule

