class rd_base_seq extends uvm_sequence#(rd_tx);
  rd_tx tx,tx_t;
  rd_tx txQ[$];
  uvm_phase phase;
  `uvm_object_utils(rd_base_seq)
  
  function new(string name="");
		super.new(name);
	endfunction
  
  task pre_body();
    phase=get_starting_phase();  //refers to run phase of env.agent.wseqr
    if(phase != null)begin
      phase.raise_objection(this);
      phase.phase_done.set_drain_time(this,100);
    end
  endtask
  
  task post_body();
    if(phase != null)phase.drop_objection(this);
  endtask 
endclass

//Write fifo depth
class rd_seq extends rd_base_seq;
  `uvm_object_utils(rd_seq)
  
  function new(string name="");
		super.new(name);
	endfunction
  
  task body();
    repeat(`DEPTH) begin
      `uvm_do(req); //write tx
    end
  endtask
    
endclass    
