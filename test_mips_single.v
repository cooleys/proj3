// Rob McGuire-Dale & Sarah Cooley
// cs472
// Lab 3
// Fall09

module test_mips_single;
	reg clk, reset;

    // instantiate a test device (DUT = Device Under Test)
    mips_single DUT( clk, reset );

    // Cycle through clk and reset combinations
    always   #1 clk = ~clk;
    always   #2 reset = ~reset;

    // Initialize signals
    initial begin
        clk = 1'b0;
        reset = 1'b0;
    end
endmodule;
