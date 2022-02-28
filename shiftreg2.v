module Shiftreg2(sclr, sset, shiftin, load, data, clock, enable, aclr, aset, shiftout, q);
	
	input  sclr, sset, shiftin, load, clock, enable, aclr, aset;
	output reg shiftout;
	parameter LOAD_AVALUE=2;
	parameter SHIFT_DIRECTION = "LEFT";
	parameter LOAD_SVALUE=3;
	parameter SHIFT_WIDTH=8;
	input [SHIFT_WIDTH-1:0] data;
	output [SHIFT_WIDTH-1:0] q;
	reg [SHIFT_WIDTH-1:0] atemp,stemp;

	assign q = (aclr||aset==1)? atemp:stemp;

	always @(*) begin
		if (aclr) begin
			atemp=0;
		end
		else if (aset) begin
			atemp=LOAD_AVALUE;
		end
	end

	always @(posedge clock) begin
		if (sclr) begin
			stemp<=0;
		end
		else if (sset) begin
			stemp<=LOAD_SVALUE;
		end
		else if (enable) begin
			if (load) begin
				stemp<=data;
			end
			else if (SHIFT_DIRECTION=="LEFT") begin
				{shiftout, stemp}<={q,shiftin};
			end
			else if (SHIFT_DIRECTION=="RIGHT") begin
				{stemp, shiftout}<={shiftin,q};
			end
		end
	end
	
endmodule