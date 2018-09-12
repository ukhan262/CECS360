`timescale 1ns / 1ps
//****************************************************************//
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360                                //
//  File name: pulse_maker.v				                              //
//                                                                //
//  Created by Umar Khan on 09/16/2017                            //
//                                                    				//
//                                                                //
//  Abstract: Generates a tick every 10ms.	                     //
//																						//
//****************************************************************//

module pulse_maker(clk, reset, pulse);

	input clk, reset;
	output pulse;
	reg [19:0] count;
		
	assign pulse = (count == 999999);
	
	always @ (posedge clk, posedge reset)
	
		if(reset) 	count <= 20'b0;	
	else
		if(pulse) count <= 20'b0; 
	else
					   count<= count + 20'b1;
			
endmodule
