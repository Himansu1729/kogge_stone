`timescale 1ns/100ps

module ks16_TB;
    reg CLK, RST_N;
    reg[15:0] A, B; 
    reg CIN;
    wire[15:0] SUM; 
    wire COUT;
	 
	 ks16 dut(.A(A), .B(B), .CIN(CIN), .CLK(CLK), .RST_N(RST_N), .SUM(SUM), .COUT(COUT));

    always #5 CLK = ~CLK;

    initial
    begin 
        $dumpfile("ks16_waveforms.vcd");
        $dumpvars(0, ks16_TB);
        $monitor($time, " CLK = %h, RST_N = %h, A = %h, B = %h, CIN = %h, S = %h, COUT = %h, a=%h, b=%h, c=%b, d=%b", CLK, RST_N, A, B, CIN, SUM, COUT, dut.l1.OUTG1, dut.l2.OUTG2, dut.l4.OUTG4, dut.s1.SUM);
        CLK = 1'b0;RST_N = 1'b0;
        #20
        RST_N = 1'b1;A = 16'h1111; B = 16'h2222; CIN = 1'b1;
        #20
        RST_N = 1'b1;A = 16'hffff; B = 16'hffff; CIN = 1'b1;
        #20
        $finish;
    end
endmodule
