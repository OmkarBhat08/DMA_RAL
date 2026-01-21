//----------------------------------------------------------------------------------------------------------------
// Base test
class dma_base_test extends uvm_test;

	dma_env env;
	dma_report_server srv;

	`uvm_component_utils(dma_base_test)

	function new(string name = "dma_base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = dma_env::type_id::create("env", this);
		srv = new();
	endfunction : build_phase

endclass : dma_base_test
//----------------------------------------------------------------------------------------------------------------
// CNTRL test
class dma_ctrl_test extends dma_base_test;

	ctrl_sequence seq;
	`uvm_component_utils(dma_ctrl_test)

	function new(string name = "dma_ctrl_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = ctrl_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.regblock = env.regblock;
		seq.start(env.agnt.seqr)
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_ctrl_test
//----------------------------------------------------------------------------------------------------------------
// IO_ADDR test
class dma_io_addr_test extends dma_base_test;

	io_addr_sequence seq;
	`uvm_component_utils(dma_io_addr_test)

	function new(string name = "dma_io_addr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = io_addr_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.regblock = env.regblock;
		seq.start(env.agnt.seqr)
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_io_addr_test
