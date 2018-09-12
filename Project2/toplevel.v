`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project2_CECS360			                        //
//  File name: top_level.v				                              //
//                                                                //
//  Created by Umar Khan 10/10/2017				                     //
//                                                                //
//  Abstract: This module has the instantiation of the vga_sync	//
//					where vga gets the values from switch for RGB 		//
//					depending on the condition of video_on.				//
//****************************************************************//

module top_level(
		input wire clk, reset,
		output wire hsync, vsync,
		output wire [11:0] rgb
		);
		
		wire video_on, R_Sync, utick;
		wire [9:0] pixel_x, pixel_y;
		reg [2:0] rgb_reg;
		wire [2:0] rgb_next;
		
		AISO u0( .clk(clk),
					.reset(reset),
					.R_Sync(R_sync));
					
		vga_sync u1( .clk(clk), 
						 .reset(reset), 
						 .utick(utick),
						 .hsync(hsync), 
						 .vsync(vsync), 
						 .pixel_x(pixel_x), 
						 .pixel_y(pixel_y), 
						 .video_on(video_on));
						 
		pixel_generator u2( .video_on(video_on),
							  .pixel_x(pixel_x),
							  .pixel_y(pixel_y),
							  .graph_rgb(rgb_next));
		 
		 always@(posedge clk, posedge reset)
			if (reset)
				rgb_reg <= 12'b0; else
			if (utick)
				rgb_reg <= rgb_next;
		
		 //output
		 assign rgb[11:8] = {4{rgb_reg[2]}};
		 assign rgb[7:4]  = {4{rgb_reg[1]}};
		 assign rgb[3:0]  = {4{rgb_reg[0]}};

endmodule
