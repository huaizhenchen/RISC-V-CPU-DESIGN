`timescale 1ns / 1ps

module Datapath(
        clk,rst, 
    
        ins_Addr,
        ins,
    
        aluOutput,memWriteData,memReadData,MemWrite,MemRead,
    
        rReadSelect1,rReadSelect2,rWriteSelect,rWriteData,rWriteEnable,rReadData1,rReadData2,
        
        ALUOp, branch, ALUSrc, MemtoReg, ALU_input2, 
        
        immediate, flag_zero,flag_minus
    
    );
    
    input wire clk,rst;
    output wire [31:0] ins;//instruction
    output wire [31:0] ins_Addr;//Instructions Address
    input wire [31:0] memReadData;//Read data from memory
    output wire [31:0] aluOutput;// Data memory Address 
    output wire [31:0] memWriteData;// Data wrote to data memory
    output wire  MemWrite; // control signal
    output wire  MemRead; // control signal
    input wire [31:0] rReadData1, rReadData2;
    output wire [4:0] rReadSelect1, rReadSelect2, rWriteSelect; // Control singal for Reginster file
    output wire [31:0] rWriteData; // Data wrote to Register file
    output wire rWriteEnable;// Control singal for Reginster file
    output wire [31:0] immediate;
    output wire flag_zero,flag_minus;
    output wire [3:0]ALUOp;
    output wire branch;
    output wire ALUSrc;
    output wire MemtoReg;
    
    
    pc_counter pc(
        .clk(clk), 
        .rst(rst), 
        .zero_flag(flag_zero), //in
        .branch(branch), //in from control unit
        .imm(immediate), //in from immediate_generator
        .pc(ins_Addr), //out
        .minus_flag(flag_minus)
    );
    
    
    Instruction_Memory im(
        .Address(ins_Addr),//out to 1. control unit, 2. register file, 3.immediate_generator
	    .ReadData1(ins)//in from pc
    );
    
    
    immediate_generator ig(
        .Read_data1(rReadSelect1),//out to register file
        .Read_data2(rReadSelect2),//out to register file
        .immediate(immediate), //out to pc 
        .writeselect(rWriteSelect),//out to register file
        .instruction(ins) //in from pc 
    );
    
    
    DataMemory dm(
        .ReadData(memReadData),//output to memory mux
        .MemoryAddress(aluOutput), //in from alu output
        .ReadEnable(MemRead), //in signal from control unit   
        .WriteEnable(MemWrite), //in signal from control unit 
        .WriteData(rReadData2), //in from alu mux
        .clk(clk),
        .rst(rst)
    );
    
    
    Register_File rf(
        .ReadData1(rReadData1),//out
        .ReadData2(rReadData2),//out  
        .ReadSelect1(rReadSelect1),//in from instruction delivery
        .ReadSelect2(rReadSelect2),//in from instruction delivery
        .address(rWriteSelect), //in from instruction delivery
        .WriteData(rWriteData), //in from data memory mux
        .WriteEnable(rWriteEnable), //in  from control unit        
        .clk(clk),
        .rst(rst)
    );
    
    
    ControlUnit cu(        
        .ALUOp(ALUOp), //out
        .MemtoReg(MemtoReg), //out 
        .Branch(branch), //out 
        .MemRead(MemRead), //out 
        .MemWrite(MemWrite), //out 
        .ALUSrc(ALUSrc), //out 
        .RegWrite(rWriteEnable),//out 
        .instruction(ins), //in 
        .rst(rst) //in
    );
    
    
    output wire [31:0] ALU_input2;
    
    Alu alu(
        .out(aluOutput),//out
        .zero(flag_zero), //out, flag
        .minus(flag_minus),//out,flag
        .a_data(rReadData1),//in
        .b_data(ALU_input2),//in
        .alu_op(ALUOp),//in       
        .clk(clk),
        .rst(rst)
    );
    
   

    assign memWriteData = rReadData2;
    assign ALU_input2 = (ALUSrc == 1'b1) ? $signed(immediate[31:0]) : rReadData2;
    //in fron control unit
    assign rWriteData = (MemtoReg == 1'b1) ? memReadData : aluOutput; //in from data memory output //in from alu output //out to register write data
   
endmodule