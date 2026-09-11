`timescale 1ns / 1ps

module lab_1b_top_level_tb();

    // Parameters
    parameter CLK_PERIOD = 10; // 10ns for 100MHz clock
    parameter QUARTER_CYCLE = CLK_PERIOD / 4;
    parameter RESET_DURATION = 5 * CLK_PERIOD;
    parameter CONVERSION_TIME = 20 * CLK_PERIOD;

    // Signals
    logic clk;
    logic reset;
    logic [15:0] switches_inputs;
    logic CA, CB, CC, CD, CE, CF, CG, DP;
    logic AN1, AN2, AN3, AN4;
    logic [15:0] led;

    // Instantiate the Unit Under Test (UUT)
    lab_1b_top_level uut (
        .clk(clk),
        .reset(reset),
        .switches_inputs(switches_inputs),
        .CA(CA),
        .CB(CB),
        .CC(CC),
        .CD(CD),
        .CE(CE),
        .CF(CF),
        .CG(CG),
        .DP(DP),
        .AN1(AN1),
        .AN2(AN2),
        .AN3(AN3),
        .AN4(AN4),
        .led(led)
    );

    // Clock generation
    always begin
        clk = 0;
        #(CLK_PERIOD / 2);

        clk = 1;
        #(CLK_PERIOD / 2);
    end

    // Test stimulus
    initial begin
        reset = 0;
        #250ns;

        reset = 1;
        #RESET_DURATION;

        reset = 0;
        #CLK_PERIOD;

        switches_inputs = 16'b0000_0000_0000_0000;
        #50ns;

        switches_inputs = 16'b1111_1111_1111_1111;
        #50ns;

        switches_inputs = 16'b0101_0101_0101_0101;
        #50ns;

        switches_inputs = 16'b1010_1010_1010_1010;
        #50ns;

        switches_inputs = 16'b1100_1100_1100_1100;
        #50ns;

        switches_inputs = 16'b0011_0011_0011_0011;
        #50ns;

        #(5 * CLK_PERIOD);
        $stop;
    end

    initial begin
        $monitor("Time = %0t: switches_inputs = %b, led = %b",
                 $time, switches_inputs, led);
    end

endmodule