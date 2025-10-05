// This is a black cell which takes G(i:k), P(i:k) & G(k-1:j), P(k-1:j)
// and outputs the cumulative generate G(i:j) & propagate P(i:j) using,
// G(i:j) = G(i:k) + P(i:k)*G(k-1:j)
// P(i:j) = P(i:k)*P(k-1:j)

// This is a purely combinational module
module black_cell(G21, P21, G10, P10, G20, P20);
    input G21, P21, G10, P10;
    output G20, P20;
    wire T;

    assign T = P21 & G10;
    assign G20 = T | G21;
    assign P20 = P21 & P10;
endmodule
