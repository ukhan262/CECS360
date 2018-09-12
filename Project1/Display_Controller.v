`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360			                        //
//  File name: Display_Controller.v                               //
//                                                                //
//  Created by Umar Khan 09/19/2017			.                       //
//                                                                //
//  Abstract: This is  where the 7 segement display module consisting of //
//				  led_clk, led_controller, ad_mux, and hex_to_7seg    //
//				  is instantiated.
//																						//
//****************************************************************//
module Display_Controller	(clk, reset, anode, seg, a, b, c, d, e, f, g);
   input             clk, reset;
   input      [31:0] seg;
	
   output      [7:0] anode;
   output            a, b, c, d, e, f, g; 
	
   wire              led_cout;
   wire        [2:0] sel;
   wire        [3:0] y;
   
   led_clk           a1(clk, reset, led_cout);
        
                     
   led_controller    a2(led_cout, reset, anode, sel);
               
                        
   ad_mux            a3(sel, seg[31:28], seg[27:24], seg[23:20],  
							seg[19:16], seg[15:12], seg[11:8], seg[7:4], 
							seg[3:0], y);
                     
   hex_to_7seg       a4(y, a, b, c, d, e, f, g);
            
endmodule
 
