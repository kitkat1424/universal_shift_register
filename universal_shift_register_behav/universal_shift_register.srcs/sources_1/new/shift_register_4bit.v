`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2024 13:29:21
// Design Name: 
// Module Name: shift_register_4bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module shift_register_4bit(
    output reg [3:0] a_par,
    input [3:0] i_par,
    input s1, s0, msb_in, lsb_in, clk, clear_b 
    );
    
always @(posedge clk, negedge clear_b) begin
    if(clear_b == 0) a_par = 4'b0000;
    else 
        case({s1, s0})
            2'b00 : a_par <= a_par; //No change
            2'b01 : a_par <= {msb_in, a_par[3:1]}; //Right-shift
            2'b10 : a_par <= {a_par[2:0], lsb_in}; //Left-shift
            2'b11 : a_par <= i_par;     
        endcase 
end
endmodule
