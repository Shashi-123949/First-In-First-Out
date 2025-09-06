class rd_driver extends uvm_driver#(rd_tx);
  virtual fifo_intrf vif;
  `uvm_component_utils(rd_driver)
  rd_tx tx;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db#(virtual fifo_intrf)::get(null,"","VIF",vif))
     `uvm_error("INTR","VIF GET FAILED");
	endfunction
  
     task run_phase(uvm_phase phase);
//        vif=top.pif;
       wait(!vif.rst);
        forever begin
          seq_item_port.get_next_item(req);
          drive(req);
          req.print();
          seq_item_port.item_done();
         end
      endtask
         
    task drive(rd_tx tx);
      @(posedge vif.rd_clk);
      vif.rd_en=1;
      vif.rdata=tx.rdata;
      @(posedge vif.rd_clk);
      vif.rd_en=0;
      vif.rdata=0;
    endtask
           
endclass

