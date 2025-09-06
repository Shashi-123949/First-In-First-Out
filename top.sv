`define PTR_WIDTH $clog2(`DEPTH)
`define WIDTH 8
`define DEPTH 16

import uvm_pkg::*;

`include "uvm_macros.svh"
`include "asyn_fifo.v"
`include "fifo_intr.sv"
`include "wr_tx.sv"
`include "rd_tx.sv"
`include "wr_seq_lib.sv"
`include "rd_seq_lib.sv"

`include "rd_driver.sv"
`include "rd_seqr.sv"
`include "rd_agent.sv"

`include "wr_driver.sv"
`include "wr_seqr.sv"
`include "wr_agent.sv"

//`include "fifo_mon.sv"
//`include "fifo_cov.sv"
`include "env.sv"
`include "test.sv"

module top;
  bit wr_clk,rd_clk,rst;
  fifo_intrf pif(wr_clk,rd_clk,rst);
  	asyn_fifo dut (.wr_clk(wr_clk),
				  .rd_clk(rd_clk),
                  .rst(rst),
				  .wr_en(pif.wr_en),
				  .rd_en(pif.rd_en),
				  .wdata(pif.wdata),
				  .rdata(pif.rdata),
				  .empty(pif.empty),
				  .full(pif.full),
                  .wr_error(pif.wr_error),
                  .rd_error(pif.rd_error));

  initial begin
    forever #5 wr_clk=~wr_clk;
  end
  initial begin
   forever #5 rd_clk=~rd_clk;
  end
  //reset
  initial begin
    rst=1;
    repeat(2)@(posedge wr_clk);
    rst=0;
    end
  initial begin
    uvm_config_db#(virtual fifo_intrf)::set(null,"*","VIF",pif);
   end

initial begin  
  run_test("test_wr_rd_fifo");
end 
   
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0);
  end
  
endmodule


