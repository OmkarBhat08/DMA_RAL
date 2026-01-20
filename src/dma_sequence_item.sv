`include "uvm_macros.svh" 
`include "defines.svh"
import uvm_pkg::*;

class dma_sequence_item extends uvm_sequence_item;

	//Inputs
	rand logic wr_en;
	rand logic rd_en;
	rand logic [`DATA_WIDTH-1:0] wdata;
	rand logic [`ADDR_WIDTH-1:0] addr;

	//Output
	logic [`DATA_WIDTH-1:0] rdata;

	`uvm_object_utils_begin(dma_sequence_item)
		`uvm_field_int(wr_en, UVM_ALL_ON)
		`uvm_field_int(rd_en, UVM_ALL_ON)
		`uvm_field_int(wdata, UVM_ALL_ON | UVM_HEX)
		`uvm_field_int(addr, UVM_ALL_ON | UVM_HEX)
		`uvm_field_int(rdata, UVM_ALL_ON | UVM_HEX)
	`uvm_object_utils_end

	function new(string name = "dma_sequence_item");
		super.new(name);
	endfunction	: new
endclass : dma_sequence_item
