`timescale 1ns / 1ps

module t_data_path;

    reg clk;
    reg rst;

    wire [31:0] ins;
    wire [31:0] ins_Addr;
    wire [31:0] memReadData;
    wire [31:0] aluOutput;
    wire [31:0] memWriteData;
    wire MemWrite;
    wire MemRead;
    wire [31:0] rReadData1; 
    wire [31:0] rReadData2;
    wire [4:0] rReadSelect1; 
    wire [4:0] rReadSelect2; 
    wire [4:0] rWriteSelect; 
    wire [31:0] rWriteData;
    wire rWriteEnable;
    wire [3:0] ALUOp;
    wire branch;
    wire ALUSrc;
    wire MemtoReg;
    wire [31:0] ALU_input2;
    wire [31:0] immediate;
    wire flag_zero,flag_minus;

    Datapath uut(
        .clk(clk), .rst(rst), 
        .ins_Addr(ins_Addr),
        .ins(ins),
        .aluOutput(aluOutput),
        .memWriteData(memWriteData),
        .memReadData(memReadData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .rReadSelect1(rReadSelect1),
        .rReadSelect2(rReadSelect2),
        .rWriteSelect(rWriteSelect),
        .rWriteData(rWriteData),
        .rWriteEnable(rWriteEnable),
        .rReadData1(rReadData1),
        .rReadData2(rReadData2),
        .ALUOp(ALUOp),
        .branch(branch),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .ALU_input2(ALU_input2),
        .immediate(immediate),
        .flag_zero(flag_zero),
        .flag_minus(flag_minus)
    );

    initial begin
        clk = 1'b1;
        rst = 1'b1;
        #10 rst = 1'b0;  
        #120 $finish;  
    end
    
    always #5 clk = ~clk;  

endmodule