program automatic uvm_top;
import uvm_pkg::*;

initial begin
	$timeformat(-9, 1, "ns", 10);
	run_test();
end

endprogram
