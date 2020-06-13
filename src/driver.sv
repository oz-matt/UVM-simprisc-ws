import uvm_pkg::*;

class drv extends uvm_driver#(arithmetic_instruction_si);
	`uvm_component_utils(drv)
	
	virtual masterif vif;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
	endfunction
	
	function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		
			//uvm_config_db#(int)::get(this, "", "port_id", port_id);
			uvm_config_db#(virtual masterif)::get(this, "", "vif", vif);
		
	endfunction: build_phase
	
	function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
			if (vif == null) begin
					`uvm_fatal("CFGERR", "Interface for Driver not set");
			end

		endfunction: end_of_elaboration_phase

	virtual task run_phase(uvm_phase phase);
			`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
		vif.nreset <= 0;
		repeat(2) @(posedge vif.clk);
		vif.nreset <= 1;
		repeat(2) @(posedge vif.clk);
		
		forever begin
			arithmetic_instruction_si i = new();
			repeat(5) @(posedge vif.clk);
			seq_item_port.get_next_item(req);
			//vif.instruction_raw = 32'h00102023;
			vif.instruction_raw = i.get_raw_bits();
			$display("raw: %X", vif.instruction_raw);
			`uvm_info("DRV_RUN", {"\n", req.sprint()}, UVM_MEDIUM);
			seq_item_port.item_done();
		end
	endtask
endclass