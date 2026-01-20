class dma_driver extends uvm_driver #(dma_sequence_item);

	virtual dma_interfs vif;

	`uvm_component_utils(dma_driver)

	function new(string name = "dma_driver", uvm_component parent = null)
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual dma_interfs)::get(this, "", "vif", vif))
			`uvm_fatal(get_type_name(), "Config not set at top")
	endfunction : build_phase

	virtual task run_phase(uvm_phase phase);
		forever
		begin
			seq_item_port.get_next_item(req);
			drive();
			seq_item_port.item_done();
		end
	endtask : run_phase	

	virtual task drive();
		repeat(1) @(posedge vif.driver_cb);
		vif.wr_en <= req.wr_en;
		vif.rd_en <= req.rd_en;
		vif.wdata <= req.wdata;
		vif.addr <= req.addr;
	endtask : drive

endclass : dma_driver
