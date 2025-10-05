// Comes after PG layer and contains 1 gray cell

// Takes 16 G inputs from 0 to 15 and outputs also
// 16 G inputs at indices 0 to 15

// Takes 16 P inputs from 0 to 15 and outputs 
// 15 P at indices 1 to 15

module layer1(P, G, CIN, OUTP1, OUTG1, CIN1);
    input [15:0] P, G;
	 input CIN;
    output CIN1;
    output [15:1] OUTP1;
    output [15:0] OUTG1;

	buffer b1(				// CIN is passed through buffer
        .A(CIN),
        .Y(CIN1)
    );

	gray_cell gc1(		    // Index 0 has a gray cell and requires CIN
		.G21(G[0]),			// generating only G
        .P21(P[0]),
        .G10(CIN),
        .G20(OUTG1[0])      
    );

    genvar i; 			   // Index 1-16 have black cells 
    generate  			   // creating both G and P
		for(i=1;i<16;i=i+1) begin : black_cell_loop   
            black_cell inst(
                .G21(G[i]),
                .P21(P[i]),
                .G10(G[i-1]),
                .P10(P[i-1]),
                .G20(OUTG1[i]),
                .P20(OUTP1[i])
            );
        end
    endgenerate

endmodule
