// Rob McGuire-Dale & Sarah Cooley
// cs472
// Lab 3
// Fall09

module test_mips_single;
    reg clk, reset;

    // Instantiate a test device (DUT = Device Under Test)
    mips_single DUT( clk, reset );

    // Clock with a period of 100 ns
	always  #100 clk = ~clk;

    initial begin
		// Initialize signals
        clk = 1'b0;
        reset = 1'b0;

        // Pull the reset up momentarily, and then back down
        @(posedge clk) reset = ~reset;
        @(negedge clk) reset = ~reset;
    end

endmodule;
