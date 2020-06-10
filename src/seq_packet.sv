`ifndef SEQ_PACKET_SV
`define SEQ_PACKET_SV

import uvm_pkg::*;

class seq_packet extends uvm_sequence_item;
	
	rand bit[31:0] data;
	rand bit[7:0] address;
	bit we;
	bit exec;
	
		`uvm_object_utils_begin(seq_packet)
				`uvm_field_int(data, UVM_ALL_ON)
				`uvm_field_int(address, UVM_ALL_ON)
		`uvm_object_utils_end
		
		function new(string name = "seq_packet");
				super.new(name);
				`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		endfunction: new
		
		function string output2string();
			return $sformatf("data=%X", data);
		endfunction
		
		function string convert2string();
			return $sformatf("data=%X", data);
		endfunction
		
endclass

`endif