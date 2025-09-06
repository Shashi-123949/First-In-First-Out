class rd_agent extends uvm_agent;
	`uvm_component_utils(rd_agent)

 	rd_seqr rseqr;
 	rd_driver rdrv;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
      super.build_phase(phase);     
      rseqr=rd_seqr::type_id::create("rseqr",this);
      rdrv=rd_driver::type_id::create("rdrv",this);
	endfunction
  
    function void connect_phase(uvm_phase phase);
     rdrv.seq_item_port.connect(rseqr.seq_item_export);
    //	mon.ap_port.connect(cov.analysis_port);
  endfunction
	
endclass


