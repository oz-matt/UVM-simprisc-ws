class tb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(tb_scoreboard)

  uvm_analysis_export #(seq_packet) axp_in;
  uvm_analysis_export #(seq_packet) axp_out;
  sb_predictor                      prd;
  sb_comparator                     cmp;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    axp_in = new("axp_in", this);
    axp_out = new("axp_out", this);
    prd = sb_predictor::type_id::create("prd", this);
    cmp = sb_comparator::type_id::create("cmp", this);
  endfunction

  function void connect_phase( uvm_phase phase );
    axp_in.connect (prd.analysis_export);
    axp_out.connect (cmp.axp_out);
    prd.results_ap.connect(cmp.axp_in);
  endfunction

endclass 