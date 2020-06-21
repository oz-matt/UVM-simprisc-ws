import uvm_pkg::*;

class simple_instruction_sequence_textonly extends uvm_sequence#(instruction_base_si);
	`uvm_object_utils(simple_instruction_sequence_textonly)

	asm_gen_simple_config_textonly aconfig;
	UVM_FILE assembly_file_out;
	
	function new (string name = "seq");
		super.new(name);
	endfunction

	task pre_start();
		if(!uvm_config_db#(asm_gen_simple_config_textonly)::get(null, "", "asm_gen_simple_config_textonly", aconfig)) 
			`uvm_fatal("T", "not aconfig");
		if(!uvm_config_db#(UVM_FILE)::get(null, "", "assembly_file_out", assembly_file_out))
			`uvm_fatal("T", "ripperino");
		
		$fwrite(assembly_file_out, ".globl _start\n");
		$fwrite(assembly_file_out, ".section .text\n");
		
	endtask
	
	task body();
		//repeat(10) begin
			/*req = instruction_base_si::type_id::create("req");
			wait_for_grant();                            //wait for grant
			assert(req.randomize());                     //randomize the req
			send_request(req);                           //send req to driver
			wait_for_item_done();                        //wait for item done from driver
			get_response(rsp);                           //get response from driver
			 */
			//`uvm_create(req)
			//`uvm_rand_send_with(req, {rs1 == 1; rd == 2;});
			//instruction_base_si hi = simple_generated_instruction_list_textonly::get_rand_instruction(LOAD | STORE | ARITHMETIC);
			//`uvm_rand_send_with(hi, {rs1 == 1; rd == 2;});
		foreach(aconfig.subsection_names[i]) begin
			$fwrite(assembly_file_out, $sformatf("%s:\n", aconfig.subsection_names[i]));
				
			for(int j=0; j<aconfig.num_instructions[i]; j++) begin
				instruction_base_si ip = asmutils::get_rand_instruction(aconfig.allowed_types[i]);
				`uvm_rand_send(ip);
				$fwrite(assembly_file_out, $sformatf("%s\n", ip.get_asm_string));
			end
		
		end
	endtask: body
	

	task post_start();
		$fwrite(assembly_file_out, ".data\n");
		$fwrite(assembly_file_out, ".pushsection .tohost,\"aw\",@progbits;\n");
		$fwrite(assembly_file_out, ".align 6;\n");
		$fwrite(assembly_file_out, ".global tohost;\n");
		$fwrite(assembly_file_out, "tohost:\n");
		$fwrite(assembly_file_out, "                .dword 0;\n");
		$fwrite(assembly_file_out, ".align 6;\n");
		$fwrite(assembly_file_out, ".global fromhost;\n");
		$fwrite(assembly_file_out, "fromhost:\n");
		$fwrite(assembly_file_out, "                .dword 0;\n");
		$fwrite(assembly_file_out, ".popsection;\n");
	endtask
	
endclass