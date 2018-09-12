`timescale 1ns / 1ps
//****************************************************************//
//  Class: CECS 360			                                       //
//  Project name: Project1_CECS360                                //
//  File name: Debounce.v				                              //
//                                                                //
//  Created by Umar Khan on 09/16/2017                            //
//                                                                //
//                                                                //
//  Abstract: Stabilizes the output instead of showing too many   //
//	 transitions.																	//
//  Reference to Pong Chu's Debounce     								   //
//                                                                //
//****************************************************************//
module Debounce(clk, reset, sw, db);

input wire clk, reset;
input wire sw;
output reg db;

// symbolic state declaration
pulse_maker pulse_maker(clk,reset, pulseit);

//Pulse_Maker		P1 (clk, reset, pulse);
	localparam [2:0]
				zero 	  = 3'b000,
				wait1_1 = 3'b001,
				wait1_2 = 3'b010,
				wait1_3 = 3'b011,
				one 	  = 3'b100,
				wait0_1 = 3'b101,
				wait0_2 = 3'b110,
				wait0_3 = 3'b111;

// number of counter bits (2"N * 2Ons = lOms tick)

 localparam N =20; 

// signal declaration

		reg [N-1:0] q_reg;
		wire [N-1 : 0] q_next ;
		wire pulse;
		reg [2:0] state_reg , state_next ;

// body
// counter to generate 10 ms tick

	always @ (posedge clk, posedge reset)
		if (reset)
			q_reg <= 0;
		else
			q_reg <= q_next;

// next-state logic
	
	assign q_next = q_reg + 1;

// output tick

	assign pulse = (q_reg==0) ? 1'b1 : 1'b0;

// debouncing FSM 
// state register

	always @ ( posedge clk , posedge reset)
		if (reset)
			state_reg <= zero;
		else
			state_reg <= state_next ;
	
	// next-state logic and output logic

	always @*
		begin
			state_next = state_reg; // default state: the same
			db = 1'b0; // default output: 0
	case (state_reg)
		
zero :
		if (sw)
			state_next = wait1_1 ;
			wait1_1 :
		if (~sw)
			state_next = zero;
		else
		
		if (pulse)
			state_next = wait1_2 ;
wait1_2 :
		if (~sw)
			state_next = zero;
		else
		if (pulse)
			state_next = wait1_3;
wait1_3 :
		if (~sw)
			state_next = zero; 
		else
		if (pulse)
			state_next = one;
one :
		begin
			db = 1'b1;
		if (~sw)
			state_next = wait0_1;
		end
wait0_1 :
		begin
			db = 1'b1;
		if (sw)
			state_next = one;
		else
		if (pulse)
			state_next = wait0_2;
		end
wait0_2 :
		begin
			db = 1'b1;
		if (sw)
			state_next = one;
		else
		if (pulse)
			state_next = wait0_3;
		end
wait0_3 :
		begin
			db = 1'b1;
		if (sw)
			state_next = one;
		else
		if (pulse)
			state_next = zero;
		end
	
		default : state_next = zero;

		endcase

	end

endmodule 