`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2024 17:28:40
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
module shift_register_4bit ( 
    output [3:0] A_par, 
    input [3:0] I_par, 
    input s1, s0,      // select input of Mux
    input MSB_in, LSB_in, CLK, Clear_b 
);
    wire [1:0] select;
    assign select = {s1, s0};
    
    // Instantiating the outputs of each mux
    // Function arguements are derived from the circuit diagram of a bi-directional shift register   
    mux_out ST0 (A_par[0], A_par[1], LSB_in, I_par[0], A_par[0], select, CLK, Clear_b);
    mux_out ST1 (A_par[1], A_par[2], A_par[0], I_par[1], A_par[1], select, CLK, Clear_b);
    mux_out ST2 (A_par[2], A_par[3], A_par[1], I_par[2], A_par[2], select, CLK, Clear_b);
    mux_out ST3 (A_par[3], MSB_in, A_par[2], I_par[3], A_par[3], select, CLK, Clear_b);
endmodule

module mux_out (input i0, i1, i2, i3, output Q, input [1:0] select, input CLK, Clr_b);
    wire out;
    Mux_4x1 M0 (out, i0, i1, i2, i3, select);
    D_flip_flop M1 (Q, out, CLK, Clr_b);
endmodule

module Mux_4x1 (output reg out, input i0, i1, i2, i3, input [1:0] select);
    always @ (select, i0, i1, i2, i3)
    case (select)
        2'b00: out = i0;
        2'b01: out = i1;
        2'b10: out = i2;
        2'b11: out = i3;
    endcase
endmodule

module D_flip_flop (Q, D, CLK, Clr_b);
output Q;
 input D, CLK, Clr_b;
 reg Q;
always @ ( posedge CLK, negedge Clr_b)
 if (!Clr_b) Q <= 1'b0; else Q <= D;
endmodule
