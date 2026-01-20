class dma_env extends uvm_env;
	
	dma_agent agnt;
	dma_subscriber scrb;

	`uvm_component_utils(dma_env)

	function new(string name = "dma_env", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = dma_agent::type_id::create("agnt", this);
		scrb = dma_subscriber::type_id::create("scrb", this);
		uvm_config_db #(uvm_active_passive_enum)::set(this, "agnt", "is_active", UVM_ACTIVE);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agnt.mon.monitor_port.connect(scrb.monitor_aport);
	endfunction : connect_phase
endclass : dma_env
