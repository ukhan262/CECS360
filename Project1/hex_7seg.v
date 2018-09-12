`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360			                        //
//  File name: hex_to_7seg.v		                                 //
//                                                                //
//  Created by Umar Khan 09/19/2017			.                       //
//                                                                //
//  Abstract: Module hex_to_7segment uses input hex and decodes   //
//				  the value to its equivalent representation for the  //
//				  NEXYS 4 seven segment display. This is outputed to  //
//				  the wires a, b, c, d, e, f, g accordingly.				//
//																						//
//****************************************************************//

module hex_to_7seg(hex, a, b, c, d, e, f, g);
   
	input		[3:0] hex;
	output			a, b, c, d, e, f, g;
	reg				a, b, c, d, e, f, g;

	always @ (hex) begin
		case (hex)
			4'b0000:	{a, b, c, d, e, f, g} = 7'b0000001;
			4'b0001: {a, b, c, d, e, f, g} = 7'b1001111;
			4'b0010: {a, b, c, d, e, f, g} = 7'b0010010;
			4'b0011: {a, b, c, d, e, f, g} = 7'b0000110;
			4'b0100: {a, b, c, d, e, f, g} = 7'b1001100;
			4'b0101: {a, b, c, d, e, f, g} = 7'b0100100;
			4'b0110: {a, b, c, d, e, f, g} = 7'b0100000;
			4'b0111: {a, b, c, d, e, f, g} = 7'b0001111;
			4'b1000: {a, b, c, d, e, f, g} = 7'b0000000;
			4'b1001: {a, b, c, d, e, f, g} = 7'b0000100;
			4'b1010: {a, b, c, d, e, f, g} = 7'b0001000;
			4'b1011: {a, b, c, d, e, f, g} = 7'b1100000;
			4'b1100: {a, b, c, d, e, f, g} = 7'b0110001;
			4'b1101: {a, b, c, d, e, f, g} = 7'b1000010;
			4'b1110: {a, b, c, d, e, f, g} = 7'b0110000;
			4'b1111: {a, b, c, d, e, f, g} = 7'b0111000;
			default: {a, b, c, d, e, f, g} = 7'b1111111;
		endcase
	end

endmodule
