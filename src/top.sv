`include "defines.svh"
`include "dma_design.sv"
`include "dma_interfs.sv"
`include "dma_pkg.sv"

import uvm_pkg::*;
import dma_pkg::*;

module top();
	bit clk, rst_n;
	dma_interfs interfs(clk, rst_n);

	dma_design DUT(
		.clk(clk),
		.rst_n(rst_n),
		.wr_en(interfs.wr_en),
		.rd_en(interfs.rd_en),
		.addr(interfs.addr),
		.wdata(interfs.wdata),
		.rdata(interfs.rdata)
	);

	always 
		#5 clk = ~clk;

	initial
	begin
		uvm_config_db #(virtual dma_interfs)::set(null, "*", "vif", interfs); 
		uvm_config_db #(int)::set(null,"*","include_coverage", 0);
		rst_n = 0;
		@(posedge clk);
		rst_n = 1; 
	end

	initial
	begin
		run_test("dma_io_addr_test");
		#100 $finish;
	end

endmodule
