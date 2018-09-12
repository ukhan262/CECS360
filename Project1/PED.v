`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360			                        //
//  File name: PED.v				                                    //
//                                                                //
//  Created by Umar Khan 09/19/2017				                     //
//                                                                //
//  Abstract: Detects the positive edge of the clock	.				//
//  			  It detects the PED as the output will only 			//
//	 			  change on the PED 												//
//																						//
//****************************************************************//
module PED(clk, reset, D, PED);

	input clk, reset, D;

	output PED;
	wire PED;
	
	reg F1;

	always @ (posedge clk, posedge reset) begin
		if (reset) 
			F1 <= 1'b00; 
		else
			F1 <= D;			
		end
		
	assign PED = {~F1 & D};		

endmodule

