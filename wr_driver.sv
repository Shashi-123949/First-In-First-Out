class wr_driver extends uvm_driver#(wr_tx);
  virtual fifo_intrf vif;
  `uvm_component_utils(wr_driver)
  wr_tx tx;
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual fifo_intrf)::get(null,"","VIF",vif))begin
       `uvm_error("INTR","VIF GET FAILED")
      end
	endfunction
  
     task run_phase(uvm_phase phase);
      // vif=top.pif;
        forever begin
          seq_item_port.get_next_item(req);
          drive(req);
          req.print();
          seq_item_port.item_done();
         end
      endtask
         
    task drive(wr_tx tx);
      //wait(vif.rst==0);
      @(posedge vif.wr_clk);
      vif.wr_en=1;
      vif.wdata=tx.wdata;
      @(posedge vif.wr_clk);
      vif.wr_en=0;
      vif.wdata=0;
    endtask
           
endclass

