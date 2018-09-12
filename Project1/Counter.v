`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360			                        //
//  File name: Counter.v				                              //
//                                                                //
//  Created by Umar Khan 09/19/2017			.                       //
//                                                                //
//  Abstract: Increments or decrements based on the switch UPHDWL.//
//																						//
//****************************************************************//
module Counter(clk, reset, inc, uphdnl, q);

	input clk, reset;
	input uphdnl, inc;
	
	output [15:0] q;
	reg [15:0] q;

	always @(posedge clk, posedge reset)

		if (reset) q <= 8'b0;
		else
		if (inc) q <= (uphdnl)? q + 16'b1 : q - 16'b1;
	
endmodule
