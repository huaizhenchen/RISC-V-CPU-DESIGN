module ControlUnit( instruction, rst, ALUOp, MemtoReg, Branch, MemRead, MemWrite, ALUSrc, RegWrite);

    input [31:0] instruction;
    input rst;

    output reg MemtoReg, RegWrite, MemRead, MemWrite, ALUSrc, Branch;
    output reg [3:0]ALUOp;


    
    always @(instruction)
        begin
        if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b111 & instruction[31:25] ==7'b0000000)//and r_type
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0000;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
              
            end 
      
        else if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b000 & instruction[31:25] == 7'b0000000)//add
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0010;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
                  
            end
        
        else if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b110 & instruction[31:25] == 7'b0000000)//or
             begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0001;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
                  
            end
        
        else if (instruction[6:0] == 7'b1100011 & instruction[14:12] == 3'b000)//BEQ
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0110;
                    ALUSrc=0;
                    RegWrite=0;
                    Branch=1;
                    
            end
        
        else if (instruction[6:0] == 7'b1100011 & instruction[14:12] == 3'b100)//blt
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0110;
                    ALUSrc=0;
                    RegWrite=0;
                    Branch=1;
                  
            end
        
        else if (instruction[6:0] == 7'b0110011 & instruction[14:12] == 3'b000 & instruction[31:25] == 7'b0100000)//SUB
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0110;
                    ALUSrc=0;
                    RegWrite=1;
                    Branch=0;
                   
            end
        
        else if (instruction[6:0] == 7'b0100011 & instruction[14:12] == 3'b010)//sw
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=1;
                    ALUOp=4'b0010;
                    ALUSrc=1;
                    RegWrite=0;
                    Branch=0;
                 
            end
        
         else if (instruction[6:0] == 7'b0000011 & instruction[14:12] == 3'b010)//lw
            begin
                    MemtoReg=1;
                    MemRead=1;
                    MemWrite=0;
                    //                
                    ALUOp=4'b0010;
                    ALUSrc=1;
                    RegWrite=1;
                    Branch=0;
                   
            end
         else if (instruction[6:0] == 7'b0110111)//lui
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0100;
                    ALUSrc=1;
                    RegWrite=1;
                    Branch=0;
                 
            end
         else if (instruction[6:0] == 7'b0010011 & instruction[14:12] == 3'b000)//addi
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0010;
                    ALUSrc=1;
                    RegWrite=1;
                    Branch=0;
                 
            end
         else if (instruction[6:0] == 7'b0010011& instruction[14:12] == 3'b110)//ori
            begin
                    MemtoReg=0;
                    MemRead=0;
                    MemWrite=0;
                    ALUOp=4'b0001;
                    ALUSrc=1;
                    RegWrite=1;
                    Branch = 0;

            end
        end
        
endmodule
