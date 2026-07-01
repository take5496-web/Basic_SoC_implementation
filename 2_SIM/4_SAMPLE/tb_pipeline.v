`timescale 1ns / 1ps

module tb_pipeline ();

 reg 		   clk, rst_n	;
 reg 	[9:0 ] in1			;
 reg 	[9:0 ] in2			;
 reg 	[9:0 ] in3			;
wire 	[11:0] piped_out	;
always #5 clk = ~clk; // 100MHz

initial begin
clk 	= 1'b0			;
	rst_n 	= 1'b0			; // rst enable
	in1 	= 10'd0			;
	in2 	= 10'd0			;
	in3 	= 10'd0			;

#10
rst_n = 1'b1			;

#20
in1 = 10'd1; in2 = 10'd2; in3 = 10'd3;
	 			
	 				// t=40: inject data2
#10
in1 = 10'd4; in2 = 10'd5; in3 = 10'd6;
	
 								
#10
in1 = 10'd7; in2 = 10'd8; in3 = 10'd9;
	 									
#50
rst_n = 1'b0;
		 													
#100
$finish;
	 															end

pipeline uut (
	.clk 	(clk		), 
	.rst_n 	(rst_n		), 
	.in1 	(in1		), 
	.in2 	(in2		), 
	.in3 	(in3		), 
	.out 	(piped_out	)
);

initial begin
	$dumpfile("./pipeline.vcd")	;
	$dumpvars(1, uut)			;
end

endmodule
