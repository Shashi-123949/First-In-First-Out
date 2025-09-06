class wr_agent extends uvm_agent;
	`uvm_component_utils(wr_agent)

	wr_seqr wseqr;
 	wr_driver wdrv;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      wseqr=wr_seqr::type_id::create("wseqr",this);
      wdrv=wr_driver::type_id::create("wdrv",this);
	endfunction
  
  function void connect_phase(uvm_phase phase);
    wdrv.seq_item_port.connect(wseqr.seq_item_export);
    //	mon.ap_port.connect(cov.analysis_export);
  endfunction
	
endclass

