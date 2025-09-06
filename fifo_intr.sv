interface fifo_intrf(input wr_clk,rd_clk,rst);
	bit wr_en;
	bit rd_en;
	bit [`WIDTH-1:0]wdata;
	bit [`WIDTH-1:0]rdata;
	bit empty;
	bit full;
	bit wr_error;
	bit rd_error;
	
	clocking bfm_cb_wr @(posedge wr_clk);
		default input #0 output #1;
		output wr_en;
		output wdata;
		input full;
		input wr_error;
	endclocking
  
	//mon clocking blocks
	clocking bfm_cb_rd @(posedge rd_clk);
		default input #1 output #1;
		output rd_en;
		input rdata;
		input empty;
		input rd_error;
	endclocking
  
		clocking mon_cb_wr @(posedge wr_clk);
		default input #1;
		input  wr_en;
		input wdata;
		input full;
		input wr_error;
	endclocking
  
	clocking mon_cb_rd @(posedge rd_clk);
		default input #1;
		input  rd_en;
		input rdata;
		input empty;
		input rd_error;
	endclocking


endinterface


