`timescale 1ns / 1ps

module t_controlUnit(

    );
    reg [31:0] instruction;
    reg rst;
    wire MemtoReg, RegWrite, MemRead, MemWrite, ALUSrc, Branch;
    wire [3:0]ALUOp;
    
    ControlUnit uut(instruction, rst, ALUOp, MemtoReg, Branch, MemRead, MemWrite, ALUSrc, RegWrite);
    
    initial
    begin
        #10 rst = 0;
        
        #20instruction <= 32'b00000000000000000111011000110011;
        #20instruction <= 32'b00000000101101011110011000110011;
        #20instruction <= 32'b00000000101101011000011001100011;
        #20instruction <= 32'b00000000101101011001011001100011;
        #20instruction <= 32'b01000000101101011000011000110011;
        #20instruction <= 32'b00000000101101011010011000100011;
        #20instruction <= 32'b00000000101101011010011000000011;
        #20instruction <= 32'b00000000101101011000011000110111;
    
        #400 $finish;
    end
endmodule