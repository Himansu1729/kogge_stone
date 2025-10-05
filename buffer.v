// Because a particular signal gets used across multiple
// layers, to decrease the Fan-out of a signal whichever 
// signal has to be passed as it is in a layer, we pass
// it through a buffer instead (A = Y)

// This is a combinational module
module buffer(A, Y);
    input A;
    output Y;
    wire T;

    assign T = ~A;
    assign Y = ~T;
endmodule
