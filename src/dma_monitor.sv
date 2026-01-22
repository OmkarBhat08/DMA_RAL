class dma_monitor extends uvm_monitor;

	virtual dma_interfs vif;
	dma_sequence_item monitor_item;
	uvm_analysis_port #(dma_sequence_item) monitor_port;

	`uvm_component_utils(dma_monitor)

	function new(string name = "dma_monitor", uvm_component parent = null);
		super.new(name, parent);
		monitor_port = new("monitor_port", this);
		monitor_item = new();
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual dma_interfs)::get(this, "", "vif", vif))
			`uvm_fatal(get_type_name(), "Config not set at top")
	endfunction : build_phase

	virtual task run_phase(uvm_phase phase);
		//@(vif.monitor_cb);
		forever
		begin
			repeat(2) @(vif.monitor_cb);
			monitor_item.wr_en = vif.wr_en;
			monitor_item.rd_en = vif.rd_en;
			monitor_item.wdata = vif.wdata;
			monitor_item.addr = vif.addr;
			monitor_item.rdata = vif.rdata;
			$display("--------------------------------------@%0t Monitor------------------------------------------", $time);
			$display("rst_n\t %0b", vif.rst_n);
			$display("wr_en\t %0b", monitor_item.wr_en);
			$display("rd_en\t %0b", monitor_item.rd_en);
			$display("addr\t %0h", monitor_item.addr);
			$display("rdata\t %0h", monitor_item.rdata);
			monitor_port.write(monitor_item);	
		end
	endtask : run_phase
endclass : dma_monitor
