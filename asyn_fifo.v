`define WIDTH 8
`define DEPTH 16
`define PTR_WIDTH $clog2(DEPTH)

module asyn_fifo(wr_clk,rd_clk,rst,wr_en,rd_en,wdata,rdata,full,empty,wr_error,rd_error);

parameter WIDTH=8;
parameter DEPTH=16;
parameter PTR_WIDTH=$clog2(DEPTH);

input wr_clk,rd_clk,rst,wr_en,rd_en;
  input [WIDTH-1:0]wdata;
output reg [WIDTH-1:0]rdata;
output reg full,empty,wr_error,rd_error;

reg[WIDTH-1:0]mem[DEPTH-1:0];
reg [PTR_WIDTH-1:0]rd_ptr_wr_clk;
reg [PTR_WIDTH-1:0]wr_ptr_rd_clk;
reg wr_tgl_rd_clk;
reg rd_tgl_wr_clk;
integer i;

reg [PTR_WIDTH-1:0]wr_ptr,rd_ptr;
reg wr_tgl,rd_tgl;

//write operation
always @(posedge wr_clk)begin
   if(rst)begin
   full=0;
   wr_error=0;
   wr_ptr=0;
   wr_tgl=0;
rd_ptr_wr_clk=0;
rd_tgl_wr_clk=0;
   for(i=0;i<DEPTH;i=i+1)mem[i]=0;
   end
      else begin
	     if(wr_en)begin
		    if(full)begin
			   wr_error=1;
			   end
			      else begin
				       mem[wr_ptr]=wdata;
					      if(wr_ptr==DEPTH-1)begin
						     //wr_ptr=0;
							 wr_tgl=~wr_tgl;
							 end
							   else 
							        wr_ptr=wr_ptr+1;
					end
				end
		end
end	

//read operation
always @(posedge rd_clk)begin
   if(rst)begin
     empty=1;
	 rd_ptr=0;
	 rd_tgl=0;
	 wr_ptr_rd_clk=0;
	 wr_tgl_rd_clk=0;
	rdata=0;
	rd_error=0;
   end
       else begin
	      if(rd_en)begin
		     if(empty)begin
                 rd_error=1;
				 end
				     else begin
					      rdata=mem[rd_ptr];
						     if(rd_ptr==DEPTH-1)begin
							   //rd_ptr=0;
							   rd_tgl=~rd_tgl;
							   end
							       else 
								       rd_ptr=rd_ptr+1;
					 end
			end		 
      end
end

//syncronisation
always@(posedge wr_clk)begin
  rd_ptr_wr_clk<=rd_ptr;
  rd_tgl_wr_clk<=rd_tgl;
end

always@(posedge rd_clk)begin
wr_ptr_rd_clk<=wr_ptr;
wr_tgl_rd_clk<=wr_tgl;
end


always@(*)begin
empty=0;
  full=0;
if(wr_ptr_rd_clk==rd_ptr && wr_tgl_rd_clk==rd_tgl)empty=1;
// else empty=0;
if(wr_ptr==rd_ptr_wr_clk && wr_tgl!=rd_tgl_wr_clk)full=1;
// else full=0;

end
endmodule


