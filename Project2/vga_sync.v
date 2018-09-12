`timescale 1ns / 1ps
//****************************************************************//
//                                                                //
//  Class: CECS 360			                                       //
//  Project name: Project2_CECS360			                        //
//  File name: vga_sync.v				                              //
//                                                                //
//  Created by Umar Khan 10/05/2017				                     //
//                                                                //
//  Abstract: This is a design of a 640 by 480 VGA screen which   //
//				  will have 25 Mhz pixel rate.								//
//				  This module will generate the timing and the 			//
//				  synchronization signals. 									//
//				  The hsync signal will scan each row and 				//
//   			  vsync signal will after the scan the whole screen	//
//****************************************************************//
module vga_sync(
    input wire clk,
    input wire reset,
    output wire hsync,
    output wire vsync,
    output wire video_on,
    output wire utick,
    output wire [9:0] pixel_x,
    output wire [9:0] pixel_y
    );
	/*
	VGA constants and 640x480 parameters from Pong Chu
	*/
	localparam  HD = 640,
					HF = 48,
					HB = 16,
					HR = 96,
					VD = 480,
					VF = 10,
					VB = 33,
					VR = 2;
	
	/*
	The VGA Sync is updated to 25Mhz rate
	*/
	reg  [1:0] clock_count;			 
	assign utick = clock_count == 2'b11;
	always @(posedge clk, posedge reset)
		if (reset) clock_count <= 2'b0; else 
			if (utick) clock_count <= 2'b0; else
					  clock_count <= clock_count + 2'b1;

	//sync counters
	reg [9:0] h_count_reg, h_count_next;
	reg [9:0] v_count_reg, v_count_next;
	
	//output
	reg v_sync_reg, h_sync_reg;
	wire v_sync_next, h_sync_next;
	
	//status signal
	wire h_end, v_end;
	
	//body
	//registers
	always @(posedge clk, posedge reset)
		if (reset) begin
			v_count_reg <= 0;
			h_count_reg <= 0;
			v_sync_reg <= 1'b0;
			h_sync_reg <= 1'b0;
		end
		else begin
			v_count_reg <= v_count_next;
			h_count_reg <= h_count_next;
			v_sync_reg <= ~ v_sync_next;
			h_sync_reg <= ~ h_sync_next;
		end
	
	/*
	Mod800 Counter
	The horizontal scan count range from 0 to 799
	HD + HF + HB + HR = 800
	*/
	assign h_end = (h_count_reg == (HD + HF + HB + HR - 1));
	
	
	
	
	/*
	The horizontal sync signal updating at the 25Hz rate
	*/
	always @(*)
		if (utick)  
			if (h_end)  h_count_next = 0; else
							h_count_next = h_count_reg + 10'b1;
		else
							h_count_next = h_count_reg;




	/*
	Mod525 Counter
	The Vertical scan count range from 0 to 524
	VD + VF + VB + VR = 525
	*/
	assign v_end = (v_count_reg == (VD + VF + VB + VR - 1));	
	
	
	
	/*
	The vertical scan count updating at the end of the horizontal
	scan.
	*/
	always @(*)
		if (utick)
			if (h_end)
				if (v_end)  v_count_next = 10'b0; else
							   v_count_next = v_count_reg + 10'b1;
			else
								v_count_next = v_count_reg;
		else
								v_count_next = v_count_reg;

	/*
	The horizontal sync signal set low active and set active
	from Horizontal scan count from 656 to 751
	HD + HB = 656
	HD + HB + HR = 752
	*/
	assign h_sync_next = (h_count_reg >= (HD + HB) &&
								 h_count_reg <= (HD + HB + HR - 1));

	/*
	The vertical sync signal set low active and set active 
	from 490 through 491
	VD + VF = 490
	VD + VF + VR = 492
	*/
	assign v_sync_next = (v_count_reg >= (VD + VF) &&
								 v_count_reg <= (VD + VF + VR - 1));
	
	//video on/off
	assign video_on = (h_count_reg < HD) && (v_count_reg < VD);
	
	//outputing the signals
	assign hsync = h_sync_reg;
	assign vsync = v_sync_reg;
	assign pixel_x = h_count_reg;
	assign pixel_y = v_count_reg;
	
endmodule
