// INTR
class intr_reg extends uvm_reg;
	`uvm_object_utils(intr_reg)
	uvm_reg_field intr_status;
	rand uvm_reg_field intr_mask;

	covergroup intr_cg();
		status_cp: coverpoint intr_status.value[0]{
														bins transfer_not_complete = {0};
														bins transfer_complete = {1};
																							}
		mask_cp: coverpoint intr_mask.value[0]{
														bins interrupt_not_enabled = {0};
														bins interrupt_enabled = {1};
																					}
	endgroup

	function new(string name = "intr_reg");
		super.new(name, 32, UVM_CVR_FIELD_VALS);
		if(has_coverage(UVM_CVR_FIELD_VALS))
			intr_cg = new();
	endfunction : new

	function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);	// Register auto called
		intr_cg.sample();
	endfunction : sample

	function void sample_values();		// mirror and predict value, has to be called 
		super.sample_values();
		intr_cg.sample();
	endfunction : sample_values

	function void build();
		intr_status =  uvm_reg_field::type_id::create("intr_status");
		intr_status.configure(this, 16, 0, "RO", 0, 16'h0000, 1, 0, 1);

		intr_mask =  uvm_reg_field::type_id::create("intr_mask");
		intr_mask.configure(this, 16, 16, "RW", 0, 16'h0000, 1, 1, 1);
	endfunction : build
endclass : intr_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// CTRL

class ctrl_reg extends uvm_reg;
 	`uvm_object_utils(ctrl_reg)
	rand uvm_reg_field start_dma;
	rand uvm_reg_field w_count;
	rand uvm_reg_field io_mem;
  uvm_reg_field Reserved;

  covergroup ctrl_cg;
    start_dma_cp: coverpoint start_dma.value;
		w_count_cp: coverpoint w_count.value{option.auto_bin_max = 4;}
    io_mem_cp: coverpoint io_mem.value{
																				bins io2mem = {0};
																				bins mem2io = {1};
																			}
  endgroup

  function new(string name = "ctrl_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      ctrl_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    ctrl_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    ctrl_cg.sample();
  endfunction : sample_values

  function void build();
    start_dma = uvm_reg_field::type_id::create("start_dma");
		start_dma.configure(this, 1, 0, "RW", 0, 1'b0, 1, 1, 1);

    w_count = uvm_reg_field::type_id::create("w_count");
		w_count.configure(this, 15, 1, "RW", 0, 16'h0000, 1, 1, 1);

    io_mem = uvm_reg_field::type_id::create("io_mem");
		io_mem.configure(this, 1, 16, "RW", 0, 1'b0, 1, 1, 1);

    Reserved = uvm_reg_field::type_id::create("Reserved");
		Reserved.configure(this, 15, 17, "RO", 0, 'h0, 1, 0, 1);
  endfunction	: build

endclass : ctrl_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// IO_ADDR

class io_addr_reg extends uvm_reg;
  `uvm_object_utils(io_addr_reg)
  rand uvm_reg_field io_addr;

  covergroup io_addr_cg;
    io_addr_cp: coverpoint io_addr.value{option.auto_bin_max = 5;}
  endgroup

  function new(string name = "io_addr_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      io_addr_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    io_addr_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    io_addr_cg.sample();
  endfunction : sample_values

  function void build();
    io_addr = uvm_reg_field::type_id::create("io_addr");
    io_addr.configure(this, 32, 0, "RW", 0, 'h0, 1, 1, 1);
  endfunction : build

endclass : io_addr_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// MEM_ADDR

class mem_addr_reg extends uvm_reg;
  `uvm_object_utils(mem_addr_reg)
  rand uvm_reg_field mem_addr;

  covergroup mem_addr_cg;
    mem_addr_cp: coverpoint mem_addr.value{option.auto_bin_max = 5;}
  endgroup

  function new(string name = "mem_addr_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      mem_addr_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    mem_addr_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    mem_addr_cg.sample();
  endfunction : sample_values

  function void build();
    mem_addr = uvm_reg_field::type_id::create("mem_addr");
    mem_addr.configure(this, 32, 0, "RW", 0, 'h0, 1, 1, 1);
  endfunction : build

endclass : mem_addr_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// EXTRA_INFO

class extra_info_reg extends uvm_reg;
  `uvm_object_utils(extra_info_reg)
  rand uvm_reg_field extra_info;

  covergroup extra_info_cg;
    extra_info_cp: coverpoint extra_info.value{option.auto_bin_max = 5;}
  endgroup

  function new(string name = "extra_info_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      extra_info_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    extra_info_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    extra_info_cg.sample();
  endfunction : sample_values

  function void build();
    extra_info = uvm_reg_field::type_id::create("extra_info");
    extra_info.configure(this, 32, 0, "RW", 0, 'h0, 1, 1, 1);
  endfunction : build

endclass : extra_info_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// STATUS

class status_reg extends uvm_reg;
  `uvm_object_utils(status_reg)
  uvm_reg_field busy;
  uvm_reg_field done;
  uvm_reg_field error;
  uvm_reg_field paused;
  uvm_reg_field current_state;
  uvm_reg_field fifo_level;
  uvm_reg_field Reserved;

  covergroup status_cg;
    option.per_instance = 1;
    busy_cp: coverpoint busy.value;
    done_cp: coverpoint done.value; 
    error_cp: coverpoint error.value;
    paused_cp: coverpoint paused.value;
    current_state_cp: coverpoint current_state.value;
    fifo_level_cp: coverpoint fifo_level.value;
  endgroup

  function new(string name = "status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      status_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    status_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    status_cg.sample();
  endfunction : sample_values

  function void build();
    busy = uvm_reg_field::type_id::create("busy");
    busy.configure(this, 1, 0, "RO", 0, 'b0, 1, 0, 1);

    done = uvm_reg_field::type_id::create("done");
    done.configure(this, 1, 1, "RO", 0, 'b0, 1, 0, 1);

    error = uvm_reg_field::type_id::create("error");
    error.configure(this, 1, 2, "RO", 0, 'b0, 1, 0, 1);

    paused = uvm_reg_field::type_id::create("paused");
    paused.configure(this, 1, 3, "RO", 0, 'b0, 1, 0, 1);

    current_state = uvm_reg_field::type_id::create("current_state");
    current_state.configure(this, 4, 4, "RO", 0, 'h0, 1, 0, 1);

    fifo_level = uvm_reg_field::type_id::create("fifo_level");
    fifo_level.configure(this, 8, 8, "RO", 0, 'h00, 1, 0, 1);

    Reserved = uvm_reg_field::type_id::create("Reserved");
    Reserved.configure(this, 16, 16, "RO", 0, 'h0, 1, 0, 1);
  endfunction : build

endclass : status_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// TRANSFER_COUNT

class transfer_count_reg extends uvm_reg;
  `uvm_object_utils(transfer_count_reg)
  uvm_reg_field transfer_count;

	covergroup transfer_count_cg;
		transfer_count_cp: coverpoint transfer_count.value{option.auto_bin_max = 5;}
	endgroup

  function new(string name = "transfer_count_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      transfer_count_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    transfer_count_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    transfer_count_cg.sample();
  endfunction : sample_values

  function void build();
    transfer_count = uvm_reg_field::type_id::create("transfer_count");
		transfer_count.configure(this, 32, 0, "RO", 0, 'h0, 1, 0, 1);
  endfunction : build

endclass : transfer_count_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// DESCRIPTOR_ADDR

class descriptor_addr_reg extends uvm_reg;
  `uvm_object_utils(descriptor_addr_reg)
  rand uvm_reg_field descriptor_addr;

  covergroup descriptor_addr_cg;
    descriptor_addr_cp: coverpoint descriptor_addr.value{ option.auto_bin_max = 5;}
  endgroup

  function new(string name = "descriptor_addr_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      descriptor_addr_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    descriptor_addr_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    descriptor_addr_cg.sample();
  endfunction : sample_values

  function void build();
    descriptor_addr = uvm_reg_field::type_id::create("descriptor_addr");
    descriptor_addr.configure(this, 32, 0, "RW", 0, 'h0, 1, 0, 1);
  endfunction : build

endclass : descriptor_addr_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// ERROR_STATUS

class error_status_reg extends uvm_reg;
  `uvm_object_utils(error_status_reg)
	rand uvm_reg_field bus_error;
  rand uvm_reg_field timeout_error;
  rand uvm_reg_field alignment_error;
  rand uvm_reg_field overflow_error;
  rand uvm_reg_field underflow_error;
  uvm_reg_field Reserved;
	uvm_reg_field error_code;
  uvm_reg_field error_addr_offset;

  covergroup error_status_cg;
    bus_error_cp: coverpoint bus_error.value{
																							bins no_bus_error = {0};
																							bins bus_error = {1};
																						}
    timeout_error_cp: coverpoint timeout_error.value{
																							bins timeout_error = {0};
																							bins no_timeout_error = {1};
																						}
    alignment_error_cp: coverpoint alignment_error.value{
																							bins no_alignment_error = {0};
																							bins alignment_error = {1};
																						}
    overflow_error_cp: coverpoint overflow_error.value{
																							bins no_overflow = {0};
																							bins overflow_error = {1};
																						}
    underflow_error_cp: coverpoint underflow_error.value{
																							bins no_underflow_error = {0};
																							bins underflow_error = {1};
																						}
  endgroup

  function new(string name = "error_status_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      error_status_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    error_status_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    error_status_cg.sample();
  endfunction : sample_values

  function void build();
    bus_error = uvm_reg_field::type_id::create("bus_error");
    bus_error.configure(this, 1, 0, "W1C", 0, 'b0, 1, 1, 1);

    timeout_error = uvm_reg_field::type_id::create("timeout_error");
    timeout_error.configure(this, 1, 1, "W1C", 0, 'b0, 1, 1, 1);

    alignment_error = uvm_reg_field::type_id::create("alignment_error");
    alignment_error.configure(this, 1, 2, "W1C", 0, 'b0, 1, 1, 1);

    overflow_error = uvm_reg_field::type_id::create("overflow_error");
    overflow_error.configure(this, 1, 3, "W1C", 0, 'b0, 1, 1, 1);

    underflow_error = uvm_reg_field::type_id::create("underflow_error");
    underflow_error.configure(this, 1, 4, "W1C", 0, 'b0, 1, 1, 1);

    Reserved = uvm_reg_field::type_id::create("Reserved");
    Reserved.configure(this, 3, 5, "RO", 1, 'h0, 1, 0, 1);

    error_code = uvm_reg_field::type_id::create("error_code");
    error_code.configure(this, 8, 8, "RO", 1, 'h0, 1, 0, 1);

    error_addr_offset = uvm_reg_field::type_id::create("error_addr_offset");
    error_addr_offset.configure(this, 16, 16, "RO", 0, 'h0, 1, 0, 1);
  endfunction : build

endclass : error_status_reg

//---------------------------------------------------------------------------------------------------------------------------------------
// CONFIG

class config_reg extends uvm_reg;
  `uvm_object_utils(config_reg)
  rand uvm_reg_field prioriti;
  rand uvm_reg_field auto_restart;
  rand uvm_reg_field interrupt_enable;
  rand uvm_reg_field burst_size;
  rand uvm_reg_field data_width;
  rand uvm_reg_field descriptor_mode; 
  uvm_reg_field Reserved;

  covergroup config_cg;
    option.per_instance = 1;
    prioriti_cp: coverpoint prioriti.value;
    auto_restart_cp: coverpoint auto_restart.value{
																							bins no_auto_restart = {0};
																							bins auto_restart = {1};
																									}
    interrupt_enable_cp: coverpoint interrupt_enable.value{
																							bins deasserted = {0};
																							bins asserted = {1};
																						}
    burst_size_cp: coverpoint burst_size.value;
    data_width_cp: coverpoint data_width.value;
    descriptor_mode_cp: coverpoint descriptor_mode.value{
																							bins descriptor_disabled = {0};
																							bins descriptor_enabled  = {1};
																						}
  endgroup

  function new(string name = "config_reg");
    super.new(name,32,UVM_CVR_FIELD_VALS);
    if(has_coverage(UVM_CVR_FIELD_VALS))
      config_cg = new();
  endfunction : new

  function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
    config_cg.sample();
  endfunction : sample

  function void sample_values();
    super.sample_values();
    config_cg.sample();
  endfunction : sample_values

  function void build();
    prioriti = uvm_reg_field::type_id::create("prioriti");
    prioriti.configure(this, 2, 0, "RW", 0, 'h0, 1, 1, 1);

    auto_restart = uvm_reg_field::type_id::create("auto_restart");
    auto_restart.configure(this, 1, 2, "RW", 1, 'h0, 1, 1, 1);

    interrupt_enable = uvm_reg_field::type_id::create("interrupt_enable");
    interrupt_enable.configure(this, 1, 3, "RW", 0, 'h0, 1, 1, 1);

    burst_size = uvm_reg_field::type_id::create("burst_size");
    burst_size.configure(this, 2, 4, "RW", 0, 'h0, 1, 1, 1);

    data_width = uvm_reg_field::type_id::create("data_width");
    data_width.configure(this, 2, 6, "RW", 0, 'h0, 1, 1, 1);

    descriptor_mode = uvm_reg_field::type_id::create("descriptor_mode");
    descriptor_mode.configure(this, 1, 8, "RW", 0, 'h0, 1, 1, 1);

    Reserved = uvm_reg_field::type_id::create("Reserved");
    Reserved.configure(this, 23, 9, "RO", 0, 'h0, 1, 0, 1);
  endfunction : build

endclass : config_reg

