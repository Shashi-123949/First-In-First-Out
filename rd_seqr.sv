//typedef uvm_sequencer#(rd_tx)rd_seqr;

class rd_seqr extends uvm_sequencer#(rd_tx);
  `uvm_component_utils(rd_seqr);
	
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("SEQ","SEQ BUILD PHASE",UVM_NONE);//verbosity
	endfunction
endclass

