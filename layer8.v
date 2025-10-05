module layer8(P, G, CIN, OUTG8, OUTP8, CIN8);
    input [15:0] G;
    input [15:7] P;
	 input CIN;
    output OUTP8, CIN8;
    output [15:0] OUTG8;

    buffer b1(
        .A(CIN),
        .Y(CIN8)
    );

    genvar k;
    generate
        for(k=0;k<7;k=k+1) begin : buffer_loop
            buffer inst1(
                .A(G[k]),
                .Y(OUTG8[k])
            );
        end   
    endgenerate

    gray_cell inst(
        .G21(G[7]),
        .P21(P[7]),
        .G10(CIN),
        .G20(OUTG8[7])
    );

    genvar j;
    generate
        for(j=8;j<15;j=j+1) begin : gray_cell_loop
            gray_cell inst(
                .G21(G[j]),
                .P21(P[j]),
                .G10(G[j-8]),
                .G20(OUTG8[j])
            );
        end   
    endgenerate

    black_cell inst2(
        .G21(G[15]),
        .P21(P[15]),
        .G10(G[7]),
        .P10(P[7]),
        .G20(OUTG8[15]),
        .P20(OUTP8)
    );
endmodule