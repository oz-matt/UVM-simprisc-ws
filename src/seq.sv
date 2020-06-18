import uvm_pkg::*;

class seq extends uvm_sequence#(instruction_base_si);
	`uvm_object_utils(seq)

	asm_gen_simple_config_textonly aconfig;
	
	function new (string name = "seq");
		super.new(name);
	endfunction

	task pre_body();
		uvm_config_db#(asm_gen_simple_config_textonly)::get(null, "", "asm_gen_simple_config_textonly", aconfig);
	endtask
	
	task body();
		repeat(10) begin
			/*req = instruction_base_si::type_id::create("req");
			wait_for_grant();                            //wait for grant
			assert(req.randomize());                     //randomize the req
			send_request(req);                           //send req to driver
			wait_for_item_done();                        //wait for item done from driver
			get_response(rsp);                           //get response from driver
			 */
			//`uvm_create(req)
			//`uvm_rand_send_with(req, {rs1 == 1; rd == 2;});
			instruction_base_si hi = simple_generated_instruction_list_textonly::get_rand_instruction(LOAD | STORE | ARITHMETIC);
			`uvm_rand_send_with(hi, {rs1 == 1; rd == 2;});
		
		end
	endtask: body

endclass