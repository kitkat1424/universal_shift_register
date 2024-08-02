`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2024 18:49:42
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

wire [3: 0] A_par; 
reg [3: 0] I_par;
reg s1, s0; 
reg MSB_in, LSB_in, CLK, Clear_b;

shift_register_4bit S0(.A_par(A_par), .I_par(I_par), .s1(s1), .s0(s0), .MSB_in(MSB_in), .LSB_in(LSB_in), .CLK(CLK), 
                        .Clear_b(Clear_b));


initial #103000 $finish;
initial begin
    CLK = 0;
    #5 forever #5 CLK = ~CLK;
end

initial begin
    Clear_b = 1;
    I_par = 4'b1111;
    s1 = 1'b1; s0 = 1'b1;
    
    LSB_in = 1'b0; MSB_in = 1'b0;   //bits to be shifted in
    
    repeat(16) #10 begin I_par = I_par - 1; end   //testing the loading 
    I_par = 4'b1111;
    
    repeat(5) #10 begin s1 = 1'b0; end   //testing the left-shift
    
    s1 = 1'b1; s0 = 1'b1;
    
    repeat(5) #10 begin s0 = 1'b0; end   //testing the right-shift after re-loading
   
    #10 s0 = 1'b0; s1 = 1'b1; 
                 
    repeat(5) Clear_b = 0; //testing asynchronous clear
    Clear_b = 1;
    
    #10 s1 = 1'b1; s0 = 1'b1; //Re-loading   
    
    //Retesting
    repeat(5) #10 begin s1 = 1'b0; end   //testing the left-shift
    
    s1 = 1'b1; s0 = 1'b1;
    
    repeat(5) #10 begin s0 = 1'b0; end   //testing the right-shift after re-loading
   
    #10 s0 = 1'b0; s1 = 1'b1;
    
    #10 s1 = 1'b1; s0 = 1'b1; //Re-loading      
    Clear_b = 0;         
end

endmodule
