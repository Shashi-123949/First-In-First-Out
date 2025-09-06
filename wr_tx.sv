class wr_tx extends uvm_sequence_item; 

	rand bit wr_en;
	rand bit [`WIDTH-1:0]wdata;

  function new(string name="");
		super.new(name);
	endfunction	

	`uvm_object_utils_begin(wr_tx)		
	`uvm_field_int(wr_en,UVM_ALL_ON);
	`uvm_field_int(wdata,UVM_ALL_ON);
	`uvm_object_utils_end

endclass

