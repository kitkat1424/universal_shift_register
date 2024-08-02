`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2024 16:21:59
// Design Name: 
// Module Name: t_shift_register_4bit
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
module t_shift_register_4bit();

wire [3:0] a_par;
reg [3:0] i_par;
reg clk, s1, s0, msb_in, lsb_in, clear_b;

shift_register_4bit S0(a_par, i_par, s1, s0, msb_in, lsb_in, clk, clear_b);

initial #103000 $finish;
initial begin
    clk = 0;
    #5 forever #5 clk = ~clk;
end

initial begin 
    i_par = 4'b1111;
    s1 = 1'b1; s0 = 1'b1;
    lsb_in = 1'b0; msb_in = 1'b0;
    
    repeat(16) #10 begin i_par = i_par - 1; end   //Testing the loading 
    i_par = 4'b1111;
    
    repeat(5) #10 begin s1 = 1'b0; end   //Testing the left-shift
    
    s1 = 1'b1; s0 = 1'b1;
    
    repeat(5) #10 begin s0 = 1'b0; end   //Testing the right-shift after re-loading
   
    #10 s0 = 1'b0; s1 = 1'b1; 
    clear_b = 1;                    //Testing asynchronous clear
end

endmodule
