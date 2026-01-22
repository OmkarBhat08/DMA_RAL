`uvm_analysis_imp_decl(_from_mon)

class dma_subscriber extends uvm_component;

	uvm_analysis_imp_from_mon #(dma_sequence_item,  dma_subscriber) monitor_aport;
	dma_sequence_item monitor_trans;
	real input_coverage, output_coverage;

	`uvm_component_utils(dma_subscriber)

	covergroup input_cov();
		wr_en_cp : coverpoint monitor_trans.wr_en;
	endgroup

	covergroup output_cov();
		rdata_cp : coverpoint monitor_trans.rdata;
	endgroup

	function new(string name = "dma_subscriber", uvm_component parent = null);
		super.new(name, parent);
		monitor_aport = new("monitor_aport", this);
		monitor_trans = new();
		input_cov = new();
		output_cov = new();
	endfunction : new
	
	function void write_from_mon (dma_sequence_item t);
		monitor_trans	= t;
		input_cov.sample();
		output_cov.sample();
	endfunction : write_from_mon

	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		input_coverage = input_cov.get_coverage();
		output_coverage = output_cov.get_coverage();
	endfunction : extract_phase

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(), $sformatf("Input Coverage = %0.2f", input_coverage), UVM_MEDIUM);
		`uvm_info(get_type_name(), $sformatf("Output Coverage = %0.2f", output_coverage), UVM_MEDIUM);
	endfunction : report_phase

endclass : dma_subscriber
