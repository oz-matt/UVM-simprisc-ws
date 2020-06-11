function seq_packet sb_predictor::sb_calc_exp (seq_packet t);
	
	seq_packet tr = seq_packet::type_id::create("tr");
	
	`uvm_info(get_type_name(), t.convert2string(), UVM_HIGH)
	tr.copy(t);

	tr.address = 0;
	return(tr);
endfunction 