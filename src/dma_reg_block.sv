`include "dma_registers.sv"
class dma_reg_block extends uvm_reg_block;
	`uvm_object_utils(dma_reg_block)

	rand intr_reg intr;
  rand ctrl_reg ctrl;
  rand io_addr_reg io_addr;
  rand mem_addr_reg mem_addr;
  rand extra_info_reg extra_info;
  rand status_reg status_reg_h;
  rand transfer_count_reg transfer_count;
  rand descriptor_addr_reg descriptor_addr;
  rand error_status_reg error_status;
  rand config_reg configur;

  function new(string name = "dma_reg_block");
    super.new(name,build_coverage(UVM_NO_COVERAGE));
  endfunction : new

  function void build();
    add_hdl_path ("top.DUT", "RTL");
    uvm_reg::include_coverage("*", UVM_CVR_ALL);

    intr = intr_reg::type_id::create("intr");
    ctrl = ctrl_reg::type_id::create("ctrl");
    io_addr = io_addr_reg::type_id::create("io_addr");
    mem_addr = mem_addr_reg::type_id::create("mem_addr");
    extra_info = extra_info_reg::type_id::create("extra_info");
    status_reg_h = status_reg::type_id::create("status_reg_h");
    transfer_count = transfer_count_reg::type_id::create("transfer_count");
    descriptor_addr = descriptor_addr_reg::type_id::create("descriptor_addr");
    error_status = error_status_reg::type_id::create("error_status");
    configur = config_reg::type_id::create("configur");

    intr.build(); 
    ctrl.build();  
    io_addr.build(); 
    mem_addr.build(); 
    extra_info.build(); 
    status_reg_h.build(); 
    transfer_count.build(); 
    descriptor_addr.build(); 
    error_status.build(); 
    configur.build(); 

    intr.configure(this); 
    ctrl.configure(this);  
    io_addr.configure(this); 
    mem_addr.configure(this); 
    extra_info.configure(this); 
    status_reg_h.configure(this); 
    transfer_count.configure(this); 
    descriptor_addr.configure(this); 
    error_status.configure(this); 
    configur.configure(this); 

    assert(intr.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(ctrl.set_coverage(UVM_CVR_FIELD_VALS));  
    assert(io_addr.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(mem_addr.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(extra_info.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(status_reg_h.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(transfer_count.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(descriptor_addr.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(error_status.set_coverage(UVM_CVR_FIELD_VALS)); 
    assert(configur.set_coverage(UVM_CVR_FIELD_VALS)); 

		// For backdoor Access
		intr.add_hdl_path_slice("intr_status",0, 16);
    intr.add_hdl_path_slice("intr_mask",16, 16);

    ctrl.add_hdl_path_slice("ctrl_start_dma",0, 1);
    ctrl.add_hdl_path_slice("ctrl_w_count",1, 15);
    ctrl.add_hdl_path_slice("ctrl_io_mem",16, 1);

    io_addr.add_hdl_path_slice("io_addr",0,32);

    mem_addr.add_hdl_path_slice("mem_addr",0,32);

    extra_info.add_hdl_path_slice("extra_info",0,32);
    
    status_reg_h.add_hdl_path_slice("status_busy",0, 1);
    status_reg_h.add_hdl_path_slice("status_done",1, 1);
    status_reg_h.add_hdl_path_slice("status_error",2, 1);
    status_reg_h.add_hdl_path_slice("status_paused",3, 1);
    status_reg_h.add_hdl_path_slice("status_current_state",4, 4);
    status_reg_h.add_hdl_path_slice("status_fifo_level",8, 8);
    
    transfer_count.add_hdl_path_slice("transfer_count",0,32);
    
    descriptor_addr.add_hdl_path_slice("descriptor_addr",0,32);
    
    error_status.add_hdl_path_slice("error_bus",0, 1);
    error_status.add_hdl_path_slice("error_timeout",1, 1);
    error_status.add_hdl_path_slice("error_alignment",2, 1);
    error_status.add_hdl_path_slice("error_overflow",3, 1);
    error_status.add_hdl_path_slice("error_underflow",4, 1);
    error_status.add_hdl_path_slice("error_code",8, 8);
    error_status.add_hdl_path_slice("error_addr_offset",16, 16);
    
    configur.add_hdl_path_slice("config_priority",0, 2);
    configur.add_hdl_path_slice("config_auto_restart",2, 1);
    configur.add_hdl_path_slice("config_interrupt_enable",3, 1);
    configur.add_hdl_path_slice("config_burst_size",4, 2);
    configur.add_hdl_path_slice("config_data_width",6, 2);
    configur.add_hdl_path_slice("config_descriptor_mode",8, 1);
    default_map = create_map("default_map", 'h400, 4, UVM_LITTLE_ENDIAN);

    default_map.add_reg(intr, 'h400, "RW"); 
    default_map.add_reg(ctrl, 'h404, "RW");  
    default_map.add_reg(io_addr, 'h408, "RW"); 
    default_map.add_reg(mem_addr, 'h40C, "RW"); 
    default_map.add_reg(extra_info, 'h410, "RW"); 
    default_map.add_reg(status_reg_h, 'h414, "RO"); 
    default_map.add_reg(transfer_count, 'h418, "RO"); 
    default_map.add_reg(descriptor_addr, 'h41C, "RW"); 
    default_map.add_reg(error_status, 'h420, "RW"); 
    default_map.add_reg(configur, 'h424, "RW"); 

		// Keep implicit predictor OFF
    default_map.set_auto_predict(0);

    lock_model();
  endfunction : build
endclass : dma_reg_block
