class fifo_env extends uvm_env;
	`uvm_component_utils(fifo_env)
	wr_agent wr_ag;
	rd_agent rd_ag;
//	fifo_mon mon;
//	fifo_cov cov;
//	fifo_sbd sbd;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
		wr_ag=wr_agent::type_id::create("wr_ag",this);
		rd_ag=rd_agent::type_id::create("rd_ag",this);
	//	mon=fifo_mon::type_id::create("mon",this);
	//	cov=fifo_cov::type_id::create("cov",this);
	//	sbd=fifo_sbd::type_id::create("sbd",this);
	endfunction

	
endclass

