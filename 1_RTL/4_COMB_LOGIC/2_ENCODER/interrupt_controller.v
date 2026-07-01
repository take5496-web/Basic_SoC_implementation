`timescale 1ns / 1ps

module interrupt_controller(
	i_int         ,	//incoding interrupt
	i_int_ack     , //CPU ack signal
	o_int_id      , //encod  interrupt ID
	o_int_req     ,	//interrupt ID
);

input  [7:0]    i_int           ;
input 	        i_int_ack       ;
output [2:0]    o_int_id        ;
output	        o_int_req       ;


reg [7:0]  r_active_int         ;

reg [2:0] o_int_id	        ;
reg 	  o_int_req	        ;
always @(*) begin
	o_int_req     = 1'b0    ;
	o_int_id      = 3'b000  ;
	r_active_int  = i_int   ;


	if (i_int_ack) begin
	    r_active_int = 8'b0000_0000;
	end else begin
	    casex(r_active_int)
		8'b1xxx_xxxx   : begin o_int_id = 3'b111; o_int_req = 1'b1; end
		8'b01xx_xxxx   : begin o_int_id = 3'b110; o_int_req = 1'b1; end
		8'b001x_xxxx   : begin o_int_id = 3'b101; o_int_req = 1'b1; end
		8'b0001_xxxx   : begin o_int_id = 3'b100; o_int_req = 1'b1; end
		8'b0000_1xxx   : begin o_int_id = 3'b011; o_int_req = 1'b1; end
		8'b0000_01xx   : begin o_int_id = 3'b010; o_int_req = 1'b1; end
		8'b0000_001x   : begin o_int_id = 3'b001; o_int_req = 1'b1; end
		8'b0000_0001   : begin o_int_id = 3'b000; o_int_req = 1'b1; end
		default        : begin o_int_id = 3'b000; o_int_req = 1'b0; end
	endcase
     end
end

endmodule
