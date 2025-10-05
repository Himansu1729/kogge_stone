// Comes after layer 4 and contains 8 gray cells, 
// 8 buffers and 1 black cell

// Takes 16 G inputs from 0 to 15 and also outputs
// 16 G at indices 0 to 15

// Takes 9 P inputs from indices 7 to 15 and outputs 
// 1 P at index 15

module layer8(P, G, CIN, OUTG8, OUTP8, CIN8);
    input [15:0] G;
    input [15:7] P;
	 input CIN;
    output OUTP8, CIN8;
    output [15:0] OUTG8;

	buffer b1(				// CIN is passed through buffer
        .A(CIN),
        .Y(CIN8)
    );

    genvar k;			   // G at indices is also passed 
    generate			   // through buffer
        for(k=0;k<7;k=k+1) begin : buffer_loop
            buffer inst1(
                .A(G[k]),
                .Y(OUTG8[k])
            );
        end   
    endgenerate

	gray_cell inst(		   // Index 7 is passed through gray
		.G21(G[7]),		   // cell, requires CIN and outputs only
		.P21(P[7]),		   // a G
        .G10(CIN),
        .G20(OUTG8[7])
    );

    genvar j;			   // Indices 8 to 14 are passed through 
    generate			   // gray cells generating only G
        for(j=8;j<15;j=j+1) begin : gray_cell_loop
            gray_cell inst(
                .G21(G[j]),
                .P21(P[j]),
                .G10(G[j-8]),
                .G20(OUTG8[j])
            );
        end   
    endgenerate

	black_cell inst2(	   // Index 15 is passed through black cell
		.G21(G[15]),	   // and generates both G and P
        .P21(P[15]),
        .G10(G[7]),
        .P10(P[7]),
        .G20(OUTG8[15]),
        .P20(OUTP8)
    );
endmodule
