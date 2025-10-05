module ks16(A, B, CIN, CLK, RST_N, SUM, COUT);
    input [15:0] A, B;
    input CIN, CLK, RST_N;
    output [15:0] SUM;
    output COUT;

    reg[32:0] INPUT_REG;
    reg[16:0] OUTPUT_REG;

    wire[16:0] OUT_WIRE;

    wire [15:0] T0P, T0G, T1G, T2G, T3G, T4G;  
    wire [15:1] T1P;
    wire [15:3] T2P;
    wire [15:7] T3P;
    wire [15:0] C;

    wire C1, C2, C4, C8, P15;

    layer_pg inst1(
        .A(INPUT_REG[32:17]),
        .B(INPUT_REG[16:1]),
        .P_OUT(T0P),
        .G_OUT(T0G)
    );

    layer1 l1(
        .P(T0P),
        .G(T0G),
        .CIN(CIN),
        .OUTP1(T1P),
        .OUTG1(T1G),
        .CIN1(C1)
    );

    layer2 l2(
        .P(T1P),
        .G(T1G),
        .CIN(C1),
        .OUTP2(T2P),
        .OUTG2(T2G),
        .CIN2(C2)
    );

    layer4 l4(
        .P(T2P),
        .G(T2G),
        .CIN(C2),
        .OUTP4(T3P),
        .OUTG4(T3G),
        .CIN4(C4)
    );

    layer8 l8(
        .P(T3P),
        .G(T3G),
        .CIN(C4),
        .OUTG8(T4G),
        .OUTP8(P15),
        .CIN8(C8)
    );

    sum_layer s1(
        .P(T0P),
        .C(T4G),
        .P15(P15),
        .CIN(INPUT_REG[0]),
        .SUM(OUT_WIRE[15:0]),
        .COUT(OUT_WIRE[16])
    );

    always @ (posedge CLK or negedge RST_N) begin
    if (RST_N == 1'b0)
        begin 
            INPUT_REG <= 33'b0; 
            OUTPUT_REG <= 17'b0;
        end
    else 
        begin 
            INPUT_REG <= {A,B,CIN};
            OUTPUT_REG <= OUT_WIRE;
        end
    end

    assign {COUT,SUM} = OUTPUT_REG;
endmodule