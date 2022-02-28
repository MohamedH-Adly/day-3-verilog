module Shiftregtb2();
	
	reg sclr, sset, shiftin, load, clock, enable, aclr, aset;
	wire shiftout;
	parameter SHIFT_DIRECTION = "LEFT";
	reg [7:0] data;
	wire [7:0] q;
	

	Shiftreg2 #(.SHIFT_DIRECTION(SHIFT_DIRECTION)) shreg2(sclr, sset, shiftin, load, data, clock, enable, aclr, aset, shiftout, q);


	initial begin
		clock=0;
		shiftin=0;
		forever begin
			#4 clock=~clock; shiftin=$random;
		end
	end

	integer i=0;

	initial begin
		sclr=0;
		sset=0;
		load=1;
		enable=1;
		aclr=0; 
		aset=0;
		data=0;
		#5
		load=0;
		#80
		enable=$random;
		load=1;
		data=$random;
		#20
		load=0;
		for (i=0;i<100;i=i+1) begin
			load=$random;
			data=$random;
			sclr=$random;
			sset=$random;
			enable=$random;
			#2;
		end
		sclr=0;
		sset=0;
		load=0;
		enable=1;
		#1
		for (i=0;i<100;i=i+1) begin
			aclr=$random;
			aset=$random;
			#1;
		end
		$stop;
	end

	initial begin
		$monitor("q=%b",q);
	end

endmodule