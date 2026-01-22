class dma_env extends uvm_env;
	
	dma_agent agnt;
	dma_subscriber scrb;

	dma_reg_block reg_block;
	dma_adapter adapter;
	uvm_reg_predictor #(dma_sequence_item) predictor;

	`uvm_component_utils(dma_env)

	function new(string name = "dma_env", uvm_component parent = null);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = dma_agent::type_id::create("agnt", this);
		scrb = dma_subscriber::type_id::create("scrb", this);
		uvm_config_db #(uvm_active_passive_enum)::set(this, "agnt", "is_active", UVM_ACTIVE);

		reg_block = dma_reg_block::type_id::create("reg_block");
		adapter = dma_adapter::type_id::create("adapter");
		predictor = uvm_reg_predictor#(dma_sequence_item)::type_id::create("predictor", this);
		reg_block.build();
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agnt.mon.monitor_port.connect(scrb.monitor_aport);

		reg_block.default_map.set_sequencer(.sequencer(agnt.seqr), .adapter(adapter) );
		reg_block.default_map.set_base_addr(0);
		predictor.map = reg_block.default_map;
		predictor.adapter = adapter;
		agnt.mon.monitor_port.connect(predictor.bus_in);
	endfunction : connect_phase

endclass : dma_env
