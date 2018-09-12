`timescale 1ns / 1ps
//****************************************************************************//
//                                                                				//
//  Class: CECS 360			                                       				//
//  Project name: Project1_CECS360			                        				//
//  File name: led_clk.v		                                 			//
//                                                                				//
//  Created by Umar Khan 09/19/2017			.                       				//
//  Abstract:                                                                 //
//          Frequency of clk_out is determined by integer count,					//
//          count = (Incoming Freq/(Outgoing Freq))/2.								//	
//          clk_out will alternate once every time clk_in 							//
//          alternates 'count' number of times. To achieve a refresh 			//
//          rate of 60Hz with 8 pixels, the output frequency must be				//
//          480hz.[Outgoing Freq = (Refresh Rate * Number of Pixels)]			//
//          To produce an output clock of 480hz, we divide the clock				//
//          every 104167 cycles. We assume that clk_in from the Nexys 4			//
//          FPGA is 100mhz.																	//
//																										//
//****************************************************************************//
//////////////////////////////////////////////////////////////////////////////////
module led_clk(clk, reset, led_clk);
   input  clk, reset;
   output led_clk;
   reg    led_clk;
   integer clk_ticks;
   
   always @(posedge clk, posedge reset) begin
      if(reset == 1'b1) begin
         clk_ticks = 0;
         led_clk   = 0;
      end
      //got a clock, so increment the counter and
      //test to see if half a period has elapsed
      else begin
         clk_ticks = clk_ticks + 1;
			//104166 is used to create 480Hz
         if (clk_ticks >= 104166) begin 
            led_clk = ~led_clk;
            clk_ticks = 0;
         end
      end
   end


endmodule