`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360	                              //
//  File name: AISO.v				                                 //
//                                                                //
//  Created by Umar Khan on 09/16/2017                            //
//                                                                //
//  Abstract: Helps with the violation of timing constraints.     //
//                                                                //
//****************************************************************//

module AISO(clk,reset, R_Sync);

	input clk, reset;
	output R_Sync;
	wire R_sync;
	reg F1, F2;

	always @ (posedge clk, posedge reset) begin

		if (reset)
			{F1,F2} <= 2'B00;
		else
			{F1,F2} <= {1'b1,F1};
		end

		assign R_Sync = !F2;

endmodule 
