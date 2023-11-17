`timescale 1ns / 1ps

module immediate_generator(
    input [31:0] instruction,
    output reg [4:0] Read_data1,
    output reg [4:0] Read_data2,
    output reg [31:0]immediate,
    output reg [4:0] writeselect
    );
    
    initial begin 
        immediate = $signed(32'b0);    
    end
    
    always@(instruction)begin
        case (instruction[6:0])
            7'b0110011: begin //r format
                    immediate = 32'b0;
                    
                Read_data1 = instruction[19:15];
                Read_data2 = instruction[24:20];
                writeselect = instruction[11:7];
            end
            
            7'b1100011: begin //sb format
                if (instruction[14:12] == 3'b000) begin //beq
                    immediate[12] = instruction[31];
                    immediate[10:5] = instruction[30:25];
                    immediate[4:1] = instruction[11:8];
                    immediate[11] = instruction[7];
                end
                else if (instruction[14:12] == 3'b100) begin //blt
                    immediate[12] = instruction[31];
                    immediate[10:5] = instruction[30:25];
                    immediate[4:1] = instruction[11:8];
                    immediate[11] = instruction[7];
                end
                    
                Read_data1 = instruction[19:15];
                Read_data2 = instruction[24:20];
//                writeselect = instruction[11:7];//
            end
            
            7'b0100011: begin // sw, s format
                if (instruction[14:12] == 3'b010)
                    immediate[11:5] = instruction[31:25];
                    immediate[4:0] = instruction[11:7];
  
                Read_data1 = instruction[19:15];
                Read_data2 = instruction[24:20];
//                writeselect = instruction[11:7];//
            end
            
           7'b0000011: begin //lw, I format
                Read_data1 = instruction[19:15];
                Read_data2 = 5'b0;
                immediate[11:0] = instruction[31:20];
                writeselect = instruction[11:7];
            end
            
            
           7'b0110111: begin //lui, u format
                Read_data1 = 5'b0;
                Read_data2 = 5'b0;
                immediate[31:12] = instruction[31:12];
                writeselect = instruction[11:7];
            end
            
          7'b0010011: begin //ori i format
                Read_data1 = instruction[19:15];
                Read_data2 = 5'b0;
                immediate[11:0] = instruction[31:20];
                writeselect = instruction[11:7];
            end
            

        endcase
    end
endmodule