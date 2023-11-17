`timescale 1ns / 1ps

module DataMemory(ReadData, ReadEnable, WriteData, WriteEnable, MemoryAddress, clk, rst);

    parameter BITSIZE = 64;
    parameter REGSIZE = 64;
    input [$clog2(REGSIZE)-1:0] MemoryAddress;;
    input [BITSIZE-1:0] WriteData;
    input WriteEnable, ReadEnable;
    output reg [BITSIZE-1:0] ReadData;
    input clk, rst;

    reg [BITSIZE-1:0] data_mem_file [REGSIZE-1:0];   
    
    initial
    begin
        data_mem_file[0] = 64'b0; // initialize x0 as 0;
        ReadData = 0;
    end
    
    integer i;                                  

    always @(*)
        begin
            if (ReadEnable && MemoryAddress != 63)
                ReadData = data_mem_file[MemoryAddress];
        end
    always @(posedge clk)
        begin
            if (rst)
                for (i=0; i<REGSIZE; i=i+1) data_mem_file[i] <= 32'b0; 
            else
            begin
                if (WriteEnable && MemoryAddress != 0)
                    data_mem_file[MemoryAddress] <= WriteData; 
            end
        end
endmodule