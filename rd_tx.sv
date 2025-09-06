class rd_tx extends uvm_sequence_item;
	rand bit rd_en;
		 bit [`WIDTH-1:0]rdata;

  function new(string name="");
		super.new(name);
	endfunction	

	`uvm_object_utils_begin(rd_tx)		
	`uvm_field_int(rd_en,UVM_ALL_ON);
	`uvm_field_int(rdata,UVM_ALL_ON);
	`uvm_object_utils_end

endclass

