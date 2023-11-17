`timescale 1ns / 1ns

module Instruction_Memory(Address, ReadData1);
parameter BITSIZE = 32;
parameter REGSIZE = 32;
input [REGSIZE-1:0] Address;
output reg [BITSIZE-1:0] ReadData1;

reg [BITSIZE-1:0] memory_file [0:REGSIZE-1]; // Entire list of memory


// Asyncronous read of memory. Was not specified.
always @(Address, memory_file[Address])
begin
ReadData1 = memory_file[Address];
end

integer i;
// method of filling the memory instead of through a test bench
initial
begin
i = 0;

i = i+1;
memory_file[i] = 32'b000000000001_00000_110_00001_0010011; //ORI R1, R0, 1 R1 stores 1

i = i+1;
memory_file[i] = 32'b00000000000000000001_00010_0110111; //LUI R2, R2 stores 100000000000

i = i+1;
memory_file[i] = 32'b0000000_00010_00001_110_00011_0110011; //OR R3, R1, R2 R3 stores 100000000001

i = i+1;
memory_file[i] = 32'b0000000_00011_00001_111_00100_0110011; //AND R4, R1, R3 R4 stores 1

i = i+1;
memory_file[i] = 32'b0_000000_00100_00001_000_0010_0_1100011; //BEQ R1, R4, 2 should branch

i = i+1;
memory_file[i] = 32'b0000000_00010_00001_000_00001_0110011; //ADD R1, R1, R2 should skip instruction

i = i+1;
memory_file[i] = 32'b0_000000_00001_00010_100_0011_0_1100011; //BLT R2, R1, 3 should branch to here, not take branch

i = i+1;
memory_file[i] = 32'b0100000_00100_00001_000_00001_0110011; //SUB R1, R1, R4 R1 stores 0

i = i+1;
memory_file[i] = 32'b0000000_00011_00010_010_01111_0100011; //SW R3, 15(R1) Mem(15) stores 100000000001

i = i+1;
memory_file[i] = 32'b000000001111_00000_010_00001_0000011; //LW R1, 15(R0) load 100000000001 from Mem(15) to R1





end
endmodule


