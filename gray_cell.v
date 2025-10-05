// This is a gray cell which takes G(i:k), P(i:k) & G(k-1:j)
// and outputs the cumulative generate G(i:j) using,
// G(i:j) = G(i:k) + P(i:k)*G(k-1:j)

// This is a purely combinational module
module gray_cell(G21, P21, G10, G20);
    input G21, P21, G10;
    output G20;
    wire T;

    assign T = P21 & G10;
    assign G20 = T | G21;
endmodule
