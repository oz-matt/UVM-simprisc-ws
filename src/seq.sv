import uvm_pkg::*;

class seq extends uvm_sequence#(instruction_base_si);
	`uvm_object_utils(seq)
	
	function new (string name = "seq");
		super.new(name);
				`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
				//set_automatic_phase_objection(1);
	endfunction
	
	task body; 
		repeat(20) begin 
			/*req = instruction_base_si::type_id::create("req"); 
			wait_for_grant();                            //wait for grant
		assert(req.randomize());                     //randomize the req                   
		send_request(req);                           //send req to driver
		wait_for_item_done();                        //wait for item done from driver
		get_response(rsp);                           //get response from driver
		*/
		`uvm_create(req)
		`uvm_rand_send(req)
		end
	endtask: body

endclass