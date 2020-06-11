module tb();
	logic clk, nreset;
	
	soc_top soc_top_inst(.*);
	
	initial begin
		clk <= 0;
		forever #1 clk <= !clk;
	end
	
	initial begin
		$fsdbDumpfile("novas.fsdb");
		$fsdbDumpvars();
		$fsdbDumpon;
		//#500
		//$finish;
	end

endmodule
