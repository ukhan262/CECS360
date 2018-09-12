`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:11:15 09/22/2017
// Design Name:   Top_Level
// Module Name:   C:/Users/ukhan/Dropbox/Project1_CECS360/testbench.v
// Project Name:  Project1_CECS360
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_Level
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg reset;
	reg inc;
	reg uphdnl;

	// Outputs
	wire [7:0] anode;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;

	// Instantiate the Unit Under Test (UUT)
	Top_Level uut (
		.clk(clk), 
		.reset(reset), 
		.inc(inc), 
		.uphdnl(uphdnl), 
		.anode(anode), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g)
	);

	always #5 clk= ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		inc = 0;
		uphdnl = 0;

		// Wait 100 ns for global reset to finish
		#100 reset = 0;
        
		// Add stimulus here
		#100 inc = 1;
	end
endmodule

