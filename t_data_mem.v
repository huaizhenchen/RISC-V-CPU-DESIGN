`timescale 1ns / 1ps


module t_DataMomery(

    );

    reg         r_en;
	wire [63:0] r_data;
	
	reg  [63:0] w_addr;
	reg  [63:0] w_data;
	reg         w_en;

	reg clk;
	reg rst;

	DataMemory uut(
		.ReadEnable(r_en),
		.ReadData(r_data),
		.MemoryAddress(w_addr),
		.WriteData(w_data),
		.WriteEnable(w_en),
		.clk(clk),
		.rst(rst)
	);

	initial begin
		rst = 1;
		#10 rst = 0;
	end

	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		r_en <= 0;
		w_addr <= 0;
		w_data <= 0;
		w_en <= 0;
	end

	initial begin
		#10; w_data <= 64'h31aa; w_addr <= 1; w_en <= 1;
		#100; w_data <= 64'h32bb; w_addr <= 2; r_en <= 1;
		#100; w_data <= 64'h33cc; w_addr <= 3;
		#100; w_data <= 64'h34dd; w_addr <= 4;
		#100; w_data <= 64'h35ee; w_addr <= 5;
		#100; w_data <= 64'h36ff; w_addr <= 6;
        #100; r_en <= 0;
		#400 $finish;
	end
endmodule