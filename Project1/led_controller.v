`timescale 1ns / 1ps
//****************************************************************************//
//                                                                				//
//  Class: CECS 360			                                       				//
//  Project name: Project1_CECS360			                        				//
//  File name: led_controller.v		                                 			//
//                                                                				//
//  Created by Umar Khan 09/19/2017			.                       				//
//  Abstract:                                                                 //
//        This shift module uses clk as an input. At every posedge clk, the	//
//        Moore state machine will increment states regardless of the clk		//
//        value (which will always be 1). Every state will output the 			//	
//        corresponding analog pins {a7,a6,a5,a4,a3,a2,a1,a0} as well as 		//
//        the present state {seg_sel}. For example the present state 000		//	
//        will turn on the rightmost segment display, as well as selecting 	//
//        the correct value to display. This moore state machine will 			//
//        activate one pixel at a time from the rightmost display to the 		//
//        leftmost display and then return to the rightmost display. This 		//
//        will cycle indefinately.															//
//																										//
//****************************************************************************//



module led_controller(clk, reset, a, seq_sel);
   input                clk, reset;
   output  reg    [7:0] a;
   output  reg    [2:0] seq_sel;
   
   
//////////////////////////////////////////////////////////////////////////////////
//                               state register and
//                              next_state variables
//////////////////////////////////////////////////////////////////////////////////
   reg            [2:0] Q;     //present state
   reg            [2:0] D;     //next state
   
//////////////////////////////////////////////////////////////////////////////////
//                         Next State Combinational Logic
//   (next state values can change anytime but will only be "clocked" below)
//////////////////////////////////////////////////////////////////////////////////
   always @(Q) begin
      case(Q)
         3'b000:     D = 3'b001;
         3'b001:     D = 3'b010;
         3'b010:     D = 3'b011;
         3'b011:     D = 3'b100;
         3'b100:     D = 3'b101;
         3'b101:     D = 3'b110;
         3'b110:     D = 3'b111;
         3'b111:     D = 3'b000;
         default     D = 3'b000;
      endcase
   end
   
//////////////////////////////////////////////////////////////////////////////////
//                     State Register Logic (Sequential Logic)
//////////////////////////////////////////////////////////////////////////////////
   always @ (posedge clk, posedge reset) begin
      if(reset == 1'b1)
         Q <= 3'b000;
      else 
         Q <= D;
   end
   
//////////////////////////////////////////////////////////////////////////////////
//                             Output Combinational Logic
//             (outputs will only change when present state changes)
//////////////////////////////////////////////////////////////////////////////////
   always @(Q) begin
      case(Q)
         3'b000:     {a, seq_sel} = 11'b01111111_000;
         3'b001:     {a, seq_sel} = 11'b10111111_001;
         3'b010:     {a, seq_sel} = 11'b11011111_010;
         3'b011:     {a, seq_sel} = 11'b11101111_011;
         3'b100:     {a, seq_sel} = 11'b11110111_100;
         3'b101:     {a, seq_sel} = 11'b11111011_101;
         3'b110:     {a, seq_sel} = 11'b11111101_110;
         3'b111:     {a, seq_sel} = 11'b11111110_111;
         default:    {a, seq_sel} = 11'b11111111_000;
      endcase
   end
         

endmodule
