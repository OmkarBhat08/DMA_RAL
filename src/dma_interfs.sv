`include "defines.svh"
interface dma_interfs(input bit clk, rst_n);

	//Inputs
	logic wr_en;
	logic rd_en;
	logic [`DATA_WIDTH-1:0] wdata;
	logic [`ADDR_WIDTH-1:0] addr;
	
	//Outputs
	logic [`DATA_WIDTH-1:0] rdata;	
	
	clocking driver_cb @(posedge clk);
		input wr_en;
		input rd_en;
		input wdata;
		input addr;
	endclocking : driver_cb

	clocking monitor_cb @(posedge clk);
		output wr_en;
		output rd_en;
		output wdata;
		output addr;
		output rdata;
		output rst_n;
	endclocking : monitor_cb

	modport DRIVER (clocking driver_cb, input clk, rst_n);
		modport MONITOR (clocking monitor_cb, input clk, rst_n);
endinterface : dma_interfs
