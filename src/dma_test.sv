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

	function void end_of_elaboration();
		print();
	endfunction : end_of_elaboration

endclass : dma_base_test
//----------------------------------------------------------------------------------------------------------------
// INTR test
class dma_intr_test extends dma_base_test;

	dma_intr_sequence seq;
	`uvm_component_utils(dma_intr_test)

	function new(string name = "dma_intr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_intr_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_intr_test
//----------------------------------------------------------------------------------------------------------------
// CNTRL test
class dma_ctrl_test extends dma_base_test;

	dma_ctrl_sequence seq;
	`uvm_component_utils(dma_ctrl_test)

	function new(string name = "dma_ctrl_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_ctrl_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_ctrl_test
//----------------------------------------------------------------------------------------------------------------
// IO_ADDR test
class dma_io_addr_test extends dma_base_test;

	dma_io_addr_sequence seq;
	`uvm_component_utils(dma_io_addr_test)

	function new(string name = "dma_io_addr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_io_addr_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_io_addr_test
//----------------------------------------------------------------------------------------------------------------
// MEM_ADDR test
class dma_mem_addr_test extends dma_base_test;

	dma_mem_addr_sequence seq;
	`uvm_component_utils(dma_mem_addr_test)

	function new(string name = "dma_mem_addr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_mem_addr_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_mem_addr_test
//----------------------------------------------------------------------------------------------------------------
// EXTRA_INFO test
class dma_extra_info_test extends dma_base_test;

	dma_extra_info_sequence seq;
	`uvm_component_utils(dma_extra_info_test)

	function new(string name = "dma_extra_info_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_extra_info_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_extra_info_test
//----------------------------------------------------------------------------------------------------------------
// STATUS test
class dma_status_test extends dma_base_test;

	dma_status_sequence seq;
	`uvm_component_utils(dma_status_test)

	function new(string name = "dma_status_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_status_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_status_test
//----------------------------------------------------------------------------------------------------------------
// TRANSFER_COUNT test
class dma_transfer_count_test extends dma_base_test;

	dma_transfer_count_sequence seq;
	`uvm_component_utils(dma_transfer_count_test)

	function new(string name = "dma_transfer_count_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_transfer_count_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_transfer_count_test
//----------------------------------------------------------------------------------------------------------------
// DESCRIPTOR_ADDR test
class dma_descriptor_addr_test extends dma_base_test;

	dma_descriptor_addr_sequence seq;
	`uvm_component_utils(dma_descriptor_addr_test)

	function new(string name = "dma_descriptor_addr_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_descriptor_addr_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_descriptor_addr_test
//----------------------------------------------------------------------------------------------------------------
// CONFIG test
class dma_configur_test extends dma_base_test;

	dma_configur_sequence seq;
	`uvm_component_utils(dma_configur_test)

	function new(string name = "dma_configur_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_configur_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_configur_test
//----------------------------------------------------------------------------------------------------------------
// ERROR_STATUS test
class dma_error_status_test extends dma_base_test;

	dma_error_status_sequence seq;
	`uvm_component_utils(dma_error_status_test)

	function new(string name = "dma_error_status_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_error_status_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_error_status_test
//----------------------------------------------------------------------------------------------------------------
// Regression test
class dma_regression_test extends dma_base_test;

	dma_regression_sequence seq;
	`uvm_component_utils(dma_regression_test)

	function new(string name = "dma_regression_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq = dma_regression_sequence::type_id::create("seq", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Objection Rasied");
		seq.reg_block = env.reg_block;
		seq.print();
			repeat(80)
				seq.start(env.agnt.seqr);
			$display("#######################################################################################################");
		phase.drop_objection(this, "Objection Dropped");
	endtask : run_phase

endclass : dma_regression_test
