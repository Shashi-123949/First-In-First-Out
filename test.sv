class fifo_test extends uvm_test;
	`uvm_component_utils(fifo_test)
	fifo_env env;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction
	
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
		env=fifo_env::type_id::create("env",this);
	endfunction

	function void end_of_eloboration();
		uvm_top.print_topology();		
	endfunction

endclass

//Functional test cases

class test_wr_rd_fifo extends fifo_test;
  `uvm_component_utils(test_wr_rd_fifo)
  
  function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction
  
  
	function void build_phase(uvm_phase phase);
      super.build_phase(phase);
	endfunction
  
  task run_phase(uvm_phase phase);
    wr_seq wr_seq_i;
    rd_seq rd_seq_i;
    //Write Read Fifo Depth
    wr_seq_i = wr_seq::type_id::create("wr_seq_i",this);
    rd_seq_i = rd_seq::type_id::create("rd_seq_i",this);
    
    phase.raise_objection(this);
    wr_seq_i.start(env.wr_ag.wseqr);
    rd_seq_i.start(env.rd_ag.rseqr);
    phase.phase_done.set_drain_time(this,100);
    phase.drop_objection(this);
  endtask

endclass
