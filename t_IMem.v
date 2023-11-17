`timescale 1ns / 1ps

module tb_Instruction_Memory();

    reg [31:0] Address;
    wire [31:0] ReadData1;

    Instruction_Memory IM(
        .Address(Address),
        .ReadData1(ReadData1)
    );

    initial begin


        Address = 32'b0;

        #10 Address = 32'd1;
        #10 Address = 32'd2;
        #10 Address = 32'd3;
        #10 Address = 32'd4;
        #10 Address = 32'd5;
        #10 Address = 32'd6;
        #10 Address = 32'd7;
        #10 Address = 32'd8;
        #10 Address = 32'd9;
        #10 Address = 32'd10;
        #10 Address = 32'd11;
        #10 Address = 32'd12;
        #10 Address = 32'd13;
        #10 Address = 32'd14;
        
        #10 Address = 32'd20;

        #20 $finish;
    end

endmodule
