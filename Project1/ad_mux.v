`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360			                        //
//  File name: hex_to_7seg.v		                                 //
//                                                                //
//  Created by Umar Khan 09/19/2017			.                       //
//                                                                //
//  Abstract: 8-to-1 4bit mux with 3 bit select(seq_sel).Output(y)//				  is always set to only one specific 4 bit input		//
//			 	  (d7,d6,d5,d4,d3,d2,d1,d0)									//
//            that is determined by the 3 bit select(seq_sel).		//
//****************************************************************//
////////////////////////////////////////////////////////////////////
module ad_mux(seq_sel, d0, d1, d2, d3, d4, d5, d6, d7, y);
   
	input    [2:0]    seq_sel;
   input    [15:12]  d0;  
   input    [11:8]   d1;  
   input    [7:4]    d2;  
   input    [3:0]    d3;  
   input    [15:12]  d4;  
   input    [11:8]   d5;  
   input    [7:4]    d6;    
   input    [3:0]    d7;       
   
	output   [3:0]    y;     //output to the hex_to_7seg
   
	reg      [3:0]    y;
   
   always @(*) begin
      case(seq_sel)
         3'b000:     y = d0;
         3'b001:     y = d1;
         3'b010:     y = d2;
         3'b011:     y = d3;
         3'b100:     y = d4;    
         3'b101:     y = d5;    
         3'b110:     y = d6;
         3'b111:     y = d7;
      endcase
   end
   
endmodule
