`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SDSU
// Engineer: Colton Beery
//
// Revision Date: 03/27/2019 1:02 PM
// Module Name: Digital_Clock
// Project Name: Digital Clock
// Target Devices: Basys 3
// Description: Digital Clock for the Basys 3 FPGA
//
// Dependencies:
//      Basys3_Master_Customized.xdc
//      7segVerilog.v
//
// Revision: 1.1
// Additional Comments: Push center button to swap between running mode and set mode. 
//                      When in set time mode
//                         - Push left/right buttons to swap between setting minutes and hours.
//                         - Push up/down buttons to increment and decrement time, respectively 
//                      SW0 toggles between AM/PM and Military time - Switch up = military, down = AM/PM
//                      When clock is set to AM/PM, LED0 on = PM
//
//////////////////////////////////////////////////////////////////////////////////


module Digital_Clock(
    input clk, // FPGA clock signal, 100 MHz
    input btnC, btnU, btnL, btnR, btnD // FPGA IO pushbuttons
    input clear,//IO Switch 0 toggles between Military and AM/PM
    output [6:0] seg, 
    output [3:0] AN, // FPGA 7-Segment Display
    output [0:0] IO_LED //LED 0 is AM/PM LED
    );

    
    
   
endmodule