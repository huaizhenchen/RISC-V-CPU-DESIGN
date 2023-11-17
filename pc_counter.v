`timescale 1ns / 1ps

module pc_counter(
    input clk,
    input rst,
    input zero_flag,
    input minus_flag,
    input branch,
    input [31:0] imm,
    output reg [31:0] pc
);

    always @ (posedge clk) begin
        if (rst) begin
            pc <= 32'h1;
        end
        // add jump instructions
        else if ((branch == 1 && (zero_flag == 1||minus_flag ==1))) begin
            pc <= pc + $signed(imm);
        end
        else
            pc <= pc + 1'b1;
    end
endmodule