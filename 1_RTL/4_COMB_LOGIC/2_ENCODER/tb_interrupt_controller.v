`timescale 1ns / 1ps

module tb_interrupt_controller;

reg [7:0] i_int      ;
reg 	  i_int_ack  ;

wire [2:0] o_int_id  ;
wire   	   o_int_req ;


interrupt_controller uut(
	.i_int       (i_int)     ,
	.i_int_ack   (i_int_ack) ,
	.o_int_id    (o_int_id)  ,
	.o_int_req   (o_int_req) ,
);

//initial begin
//$dumpfile("./interrupt_dontroller.vcd") ;
//$dumpvars(0, tb_interrupt_controller)   ;
//end

initial begin

	$monitor("time=%0t | i_int=%b | i_int_ack=%b | o_int_id=%b | o_int_req=%b",
			$time, i_int, i_int_ack, o_int_id, o_int_req);

	i_int		= 8'b0000_0000	;
	i_int_ack	= 1'b0		;


	#10 i_int	= 8'b0000_0001	;
	#10 i_int	= 8'b0010_0000	;
	#10 i_int	= 8'b1000_0000	;
	#10 i_int_ack	= 1'b1		;
	#10 i_int_ack	= 1'b0		;

	#10 i_int	= 8'b0100_0010	;
	#10 i_int_ack	= 1'b1		;
	#10 i_int_ack	= 1'b0		;

	#10 i_int	= 8'b0000_0000	;

	#20 $finish;
end
endmodule
