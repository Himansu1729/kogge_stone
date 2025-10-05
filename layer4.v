// Comes after layer 2 and contains 4 gray cells

// Takes 16 G inputs from 0 to 15 and also outputs
// 16 G at indices 0 to 15

// Takes 13 P inputs from indices 3 to 15 and outputs 
// 9 P at indices 7 to 15

module layer4(P, G, CIN, OUTP4, OUTG4, CIN4);
    input [15:0] G;
    input [15:3] P;
	 input CIN;
    output [15:7] OUTP4;
    output [15:0] OUTG4;
	 output CIN4;

	buffer b1(				// CIN is passed through buffer
        .A(CIN),
        .Y(CIN4)
    );

    genvar k;
    generate				// G at indices 0 to 2 are passed through buffer
        for(k=0;k<3;k=k+1) begin : buffer_loop
            buffer inst1(
                .A(G[k]),
                .Y(OUTG4[k])
            );
        end   
    endgenerate

	gray_cell inst1(	  	// Index 3 is passed through gray cell
		.G21(G[3]),			// requires CIN
        .P21(P[3]),
        .G10(CIN),
        .G20(OUTG4[3])
    );
    
    genvar j;			    // Indices 4 to 6 are also passed through
    generate				// gray cell generating only G 
        for(j=4;j<7;j=j+1) begin : gray_cell_loop
            gray_cell inst(
                .G21(G[j]),
                .P21(P[j]),
                .G10(G[j-4]),
                .G20(OUTG4[j])
            );
        end   
    endgenerate

    genvar i; 			  	// Indices 7 to 15 are passed through  
    generate  				// black cells generating both P and G
        for(i=7;i<16;i=i+1) begin : black_cell_loop
            black_cell inst(
                .G21(G[i]),
                .P21(P[i]),
                .G10(G[i-4]),
                .P10(P[i-4]),
                .G20(OUTG4[i]),
                .P20(OUTP4[i])
            );
        end
    endgenerate

endmodule
