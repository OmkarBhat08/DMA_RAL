package dma_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "dma_register_block.sv"
	`include "dma_report_server.sv"

	`include "dma_sequence_item.sv"
	`include "dma_sequencer.sv"
	`include "dma_driver.sv"
	`include "dma_monitor.sv"
	`include "dma_adapter.sv" 
	`include "dma_subscriber.sv"
	`include "dma_agent.sv"
	`include "dma_env.sv"
	`include "dma_sequence.sv"
	`include "dma_test.sv"
endpackage
