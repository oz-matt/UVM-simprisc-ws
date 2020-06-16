import uvm_pkg::*;

class seq extends uvm_sequence#(load_instruction_si);
  `uvm_object_utils(seq)

  function new (string name = "seq");
    super.new(name);
  endfunction

  task body;
    repeat(20) begin
      /*req = load_instruction_si::type_id::create("req");
       wait_for_grant();                            //wait for grant
       assert(req.randomize());                     //randomize the req
       send_request(req);                           //send req to driver
       wait_for_item_done();                        //wait for item done from driver
       get_response(rsp);                           //get response from driver
       */
      `uvm_create(req)
      `uvm_rand_send_with(req, {rs1 == 1; i_imm == 0; rd == 2;});
    end
  endtask: body

  task post_body();
    `uvm_info("REGFILE", "omggg", UVM_HIGH);
  endtask

endclass