`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360			                        //
//  File name: Top_Level.v				                              //
//                                                                //
//  Created by Umar Khan 09/19/2017				                     //
//                                                                //
//  Abstract: Instantiation of all the modules.	                  //
//                                                                //
//****************************************************************//
module Top_Level (clk, reset, inc, uphdnl, anode, a, b, c, d, e, f, g);
	 
	 input  clk, reset, inc, uphdnl;
	 
	 output [7:0] anode;
	 output a, b, c, d, e, f, g;
	 
	 wire   [31:0] q;
	 wire   PED;
	 wire   reset_out;
	 wire   deb;
	 

	 Debounce
		debounce(clk, reset_out, inc, deb);
		
	 AISO
		aiso(clk, reset, reset_out);	
		
	 PED 
		ped(clk, reset_out, deb, PED);

	 Counter
		counter(clk, reset_out, PED, uphdnl, q);
	
	 Display_Controller 
		dc(clk, reset_out, anode, q, a, b ,c ,d ,e, f,g);
	
endmodule
