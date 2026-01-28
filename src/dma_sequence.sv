// INTR_SEQ
class dma_intr_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_intr_sequence)

	function new(string name = "dma_intr_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data ,r_data;
		bit [15:0] intr_status, intr_mask;
		w_data[31:1] = $urandom(); 
		w_data[0] = $urandom_range(0,1); 

		// Poke random value to register
		`uvm_info("POKING_DATA", $sformatf("intr = %0h", w_data), UVM_MEDIUM)
		reg_block.intr.poke(status, w_data);
		intr_status = w_data[15:0];
		reg_block.intr.sample_values();
		
		//Re randomize to later check for poke
		w_data[31:0] = $urandom(); 
		reg_block.intr.write(status, w_data, UVM_BACKDOOR);
		intr_mask = w_data[31:16];
		reg_block.intr.sample_values();

		// Backdoor Read the value from the register
		reg_block.intr.read(status, r_data, UVM_BACKDOOR); 
		`uvm_info(get_type_name(), $sformatf("Read from INTR register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from INTR register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Read Value\tExpected Value");
		$display("intr_status\t     %0h\t    %0h",r_data[15:0], intr_status);
		$display("intr_mask\t     %0h\t    %0h",r_data[31:16], intr_mask);

		// Check the written and read values
		if(intr_status  === r_data[15:0])
			`uvm_info(get_type_name(),"intr_status field of INTR register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"intr_status field of register test FAILED",UVM_NONE)

		if(intr_mask === r_data[31:16])
			`uvm_info(get_type_name(),"intr_mask field of INTR register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"intr_mask field of register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_intr_sequence
//--------------------------------------------------------------------------------------------------------------------------
// CNTRL_SEQ
class dma_ctrl_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_ctrl_sequence)

	function new(string name = "dma_ctrl_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data ,r_data, mirror;

		//w_data = $urandom();
		w_data[0] = $urandom_range(0,1);
		w_data[15:1] = $urandom(); 
		w_data[16] = $urandom_range(0,1);
		w_data[31:17] = $urandom(); 

		// Frontdoor write to register
		`uvm_info(get_type_name(), $sformatf("Writing to CTRL = %0h", w_data), UVM_MEDIUM)
		reg_block.ctrl.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to CTRL register failed")
		reg_block.ctrl.sample_values();

		// Frontdoor Read from the register
		reg_block.ctrl.read(status, r_data, UVM_FRONTDOOR); 
		`uvm_info(get_name(), $sformatf("Read from CTRL register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from CTRL register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Write Value\tRead Value");
		$display("start_dma\t     %0h              %0h",w_data[0], r_data[0]);
		$display("w_count\t    %0h\t  %0h",w_data[15:1], r_data[15:1]);
		$display("io_mem\t     %0h              %0h",w_data[16], r_data[16]);
		$display("Reserved\t    %0h\t    %0h\t (NOT COMPARED)",w_data[31:17], r_data[31:17]);

		// Check the written and read values
		if(w_data[16:0] === r_data[16:0])
			`uvm_info(get_type_name(),"CTRL register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"CTRL register test FAILED",UVM_NONE)

	endtask : body

endclass : dma_ctrl_sequence
//--------------------------------------------------------------------------------------------------------------------------
// IO_ADDR_SEQ
class dma_io_addr_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_io_addr_sequence)

	function new(string name = "dma_io_addr_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data , r_data;
		w_data = $urandom(); 

		// Write random value to register
		`uvm_info(get_type_name(), $sformatf("Writing to io_addr = %0h", w_data), UVM_MEDIUM)
		reg_block.io_addr.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to IO_ADDR register failed")
		reg_block.io_addr.sample_values();

		// Read the value from the register
		reg_block.io_addr.read(status, r_data, UVM_FRONTDOOR); 
		`uvm_info(get_name(), $sformatf("Read from IO_ADDR register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from IO_ADDR register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Write Value\tRead Value");
		$display("io_addr\t    %0h\t  %0h",w_data, r_data);

		// Check the written and read values
		if(w_data === r_data)
			`uvm_info(get_type_name(),"IO_ADDR register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"IO_ADDR register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_io_addr_sequence
//--------------------------------------------------------------------------------------------------------------------------
// MEM_ADDR_SEQ
class dma_mem_addr_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_mem_addr_sequence)

	function new(string name = "dma_mem_addr_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data , r_data;
		w_data = $urandom(); 

		// Write random value to register
		`uvm_info(get_type_name(), $sformatf("Writing to MEM_ADDR = %0h", w_data), UVM_MEDIUM)
		reg_block.mem_addr.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to MEM_ADDR register failed")

		// Read the value from the register
		reg_block.mem_addr.read(status, r_data, UVM_FRONTDOOR); 
		`uvm_info(get_name(), $sformatf("Read from MEM_ADDR register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from MEM_ADDR register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Write Value\tRead Value");
		$display("mem_addr\t    %0h\t  %0h",w_data, r_data);

		// Check the written and read values
		if(w_data === r_data)
			`uvm_info(get_type_name(),"MEM_ADDR register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"MEM_ADDR register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_mem_addr_sequence
//--------------------------------------------------------------------------------------------------------------------------
// EXTRA_INFO_SEQ
class dma_extra_info_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_extra_info_sequence)

	function new(string name = "dma_extra_info_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data , r_data;
		w_data = $urandom(); 

		// Write random value to register
		`uvm_info(get_type_name(), $sformatf("Writing to EXTRA_INFO = %0h", w_data), UVM_MEDIUM)
		reg_block.extra_info.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to EXTRA_INFO register failed")

		// Read the value from the register
		reg_block.extra_info.read(status, r_data, UVM_FRONTDOOR); 
		`uvm_info(get_name(), $sformatf("Read from EXTRA_INFO register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from EXTRA_INFO register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Write Value\tRead Value");
		$display("extra_info\t    %0h\t  %0h",w_data, r_data);

		// Check the written and read values
		if(w_data === r_data)
			`uvm_info(get_type_name(),"EXTRA_INFO register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"EXTRA_INFO register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_extra_info_sequence
//--------------------------------------------------------------------------------------------------------------------------
// STATUS_SEQ
class dma_status_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_status_sequence)

	function new(string name = "dma_status_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data ,r_data;
		bit status_busy, status_done, status_error, status_paused;
		bit [3:0] status_current_state;
		bit [7:0] status_fifo_level; 

		w_data[0] = $urandom_range(0,1); 
		w_data[1] = $urandom_range(0,1); 
		w_data[2] = $urandom_range(0,1); 
		w_data[3] = $urandom_range(0,1); 
		w_data[7:4] = $urandom(); 
		w_data[15:8] = $urandom(); 

		// Poke random value to register
		`uvm_info("POKING_DATA", $sformatf("status = %0h", w_data), UVM_MEDIUM)
		reg_block.status_reg_h.poke(status, w_data);
		{status_busy, status_done, status_error, status_paused} = w_data[3:0];
		status_current_state = w_data[7:4];
		status_fifo_level = w_data[15:8];
		reg_block.status_reg_h.sample_values();
		
		//Re randomize to later check for poke
		w_data[3:0] = 4'b0000; 
		w_data[7:4] = $urandom(); 
		w_data[15:8] = $urandom(); 
		reg_block.status_reg_h.write(status, w_data, UVM_BACKDOOR);

		// Backdoor Read the value from the register
		reg_block.status_reg_h.read(status, r_data, UVM_BACKDOOR); 
		`uvm_info(get_name(), $sformatf("Read from INTR register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from INTR register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Read Value\tExpected Value");
		$display("busy\t\t\t%0h\t    %0h",r_data[0], status_busy);
		$display("done\t\t\t%0h\t    %0h",r_data[1], status_done);
		$display("error\t\t\t%0h\t    %0h",r_data[2], status_error);
		$display("paused\t\t%0h\t    %0h",r_data[3], status_paused);
		$display("current_state\t        %0h\t    %0h",r_data[7:4], status_current_state);
		$display("fifo_level\t       %0h\t    %0h",r_data[15:8], status_fifo_level);
		$display("Reserved\t       %0h\t    0   (NOT COMPARED)",r_data[31:16]);

		// Check the written and read values
		if(status_busy === r_data[0])
			`uvm_info(get_type_name(),"busy field of STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"busy field of STATUS register test FAILED",UVM_NONE)

		if(status_done === r_data[1])
			`uvm_info(get_type_name(),"done field of STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"done field of STATUS register test FAILED",UVM_NONE)

		if(status_error === r_data[2])
			`uvm_info(get_type_name(),"error field of STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"error field of STATUS register test FAILED",UVM_NONE)

		if(status_paused === r_data[1])
			`uvm_info(get_type_name(),"paused field of STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"paused field of STATUS register test FAILED",UVM_NONE)

		if(status_current_state === r_data[7:4])
			`uvm_info(get_type_name(),"current_state field of STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"current_state field of STATUS register test FAILED",UVM_NONE)

		if(status_fifo_level === r_data[15:8])
			`uvm_info(get_type_name(),"fifo_level field of STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"fifo_level field of STATUS register test FAILED",UVM_NONE)

	endtask : body

endclass : dma_status_sequence
//--------------------------------------------------------------------------------------------------------------------------
// TRANSFER_COUNT_SEQ
class dma_transfer_count_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_transfer_count_sequence)

	function new(string name = "dma_transfer_count_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data ,r_data;
		bit [31:0] transfer_count;
		w_data[31:0] = $urandom(); 

		// Poke random value to register
		`uvm_info("POKING_DATA", $sformatf("transfer_count = %0h", w_data), UVM_MEDIUM)
		reg_block.transfer_count.poke(status, w_data);
		transfer_count = w_data[31:0];
		reg_block.transfer_count.sample_values();
		
		//Re randomize to later check for poke
		w_data[31:0] = $urandom(); 
		reg_block.transfer_count.write(status, w_data, UVM_BACKDOOR);

		// Backdoor Read the value from the register
		reg_block.transfer_count.read(status, r_data, UVM_BACKDOOR); 
		`uvm_info(get_name(), $sformatf("Read from TRANSFER_COUNT register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from TRANSFER_COUNT register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Read Value\tExpected Value");
		$display("transfer_count\t     %0h\t    %0h",r_data[31:0], transfer_count);

		// Check the written and read values
		if(transfer_count  === r_data[31:0])
			`uvm_info(get_type_name(),"transfer_count field of TRANSFER_COUNT register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"transfer_count field of TRANSFER_COUNT register test FAILED",UVM_NONE)

	endtask : body

endclass : dma_transfer_count_sequence
//--------------------------------------------------------------------------------------------------------------------------
// DESCRIPTOR_ADDR_SEQ
class dma_descriptor_addr_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_descriptor_addr_sequence)

	function new(string name = "dma_descriptor_addr_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data , r_data;
		w_data = $urandom(); 

		// Write random value to register
		`uvm_info(get_type_name(), $sformatf("Writing to descriptor_addr = %0h", w_data), UVM_MEDIUM)
		reg_block.descriptor_addr.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to DESCRIPTOR_ADDR register failed")

		// Read the value from the register
		reg_block.descriptor_addr.read(status, r_data, UVM_FRONTDOOR); 
		`uvm_info(get_name(), $sformatf("Read from DESCRIPTOR_ADDR register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from DESCRIPTOR_ADDR register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Write Value\tRead Value");
		$display("descriptor_addr\t    %0h\t  %0h",w_data, r_data);

		// Check the written and read values
		if(w_data === r_data)
			`uvm_info(get_type_name(),"DESCRIPTOR_ADDR register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"DESCRIPTOR_ADDR register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_descriptor_addr_sequence
//--------------------------------------------------------------------------------------------------------------------------
// CONFIG_SEQ
class dma_configur_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_configur_sequence)

	function new(string name = "dma_configur_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data ,r_data;

		//w_data = $urandom();
		w_data[1:0] = $urandom_range(0,3); 
		w_data[2] = $urandom_range(0,1); 
		w_data[3] = $urandom_range(0,1); 
		w_data[8] = $urandom_range(0,1); 
		w_data[5:4] = $urandom_range(0,3); 
		w_data[7:6] = $urandom_range(0,3); 
		w_data[31:9] = $urandom(); 

		// Frontdoor write to register
		`uvm_info(get_type_name(), $sformatf("Writing to CONFIG = %0h", w_data), UVM_MEDIUM)
		reg_block.configur.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to CONFIG register failed")
		reg_block.configur.sample_values();

		// Frontdoor Read from the register
		reg_block.configur.read(status, r_data, UVM_FRONTDOOR); 
		`uvm_info(get_name(), $sformatf("Read from CONFIG register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from CONFIG register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Write Value\tRead Value");
		$display("priority\t        %0h           %0h",w_data[1:0], r_data[1:0]);
		$display("auto_restart\t        %0h\t    %0h",w_data[2], r_data[2]);
		$display("interrupt_enable\t%0h           %0h",w_data[3], r_data[3]);
		$display("burst_size\t        %0h           %0h",w_data[5:4], r_data[5:4]);
		$display("data_width\t        %0h           %0h",w_data[7:6], r_data[7:6]);
		$display("descriptor_mode\t%0h           %0h",w_data[8], r_data[8]);
		$display("Reserved\t    %0h\t    %0h\t (NOT COMPARED)",w_data[31:9], r_data[31:9]);

		// Check the written and read values
		if(w_data[1:0] === r_data[1:0])
			`uvm_info(get_type_name(),"priority field of CONFIG register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"priority field of CONFIG register test FAILED",UVM_NONE)

		if(w_data[2] === r_data[2])
			`uvm_info(get_type_name(),"auto_restart field of CONFIG register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"auto_restart field of CONFIG register test FAILED",UVM_NONE)


		if(w_data[3] === r_data[3])
			`uvm_info(get_type_name(),"interrupt_enable field of CONFIG register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"interrupt_enable field of CONFIG register test FAILED",UVM_NONE)
		if(w_data[5:4] === r_data[5:4])
			`uvm_info(get_type_name(),"burst_size field of CONFIG register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"burst_size field of CONFIG register test FAILED",UVM_NONE)
		if(w_data[7:6] === r_data[7:6])
			`uvm_info(get_type_name(),"data_width field of CONFIG register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"data_width field of CONFIG register test FAILED",UVM_NONE)

		if(w_data[8] === r_data[8])
			`uvm_info(get_type_name(),"descriptor_mode field of CONFIG register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"descriptor_mode field of CONFIG register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_configur_sequence
//--------------------------------------------------------------------------------------------------------------------------
// ERROR_STATUS_SEQ
class dma_error_status_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;
	`uvm_object_utils(dma_error_status_sequence)

	function new(string name = "dma_error_status_sequence");
		super.new(name);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [`DATA_WIDTH-1:0] w_data ,r_data;
		bit bus_error, timeout_error, alignment_error, overflow_error, underflow_error;
		bit [2:0] Reserved;
		bit [7:0] error_code;
		bit [15:0] error_addr_offset;

		w_data[0] = $urandom_range(0,1);
		w_data[1] = $urandom_range(0,1);
		w_data[2] = $urandom_range(0,1);
		w_data[3] = $urandom_range(0,1);
		w_data[4] = $urandom_range(0,1);
		w_data[31:5] = $random();

		// Poke the value to register
		`uvm_info(get_type_name(), $sformatf("Poke value to ERROR_STATUS = %0h", w_data), UVM_MEDIUM)
		reg_block.error_status.poke(status, w_data);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Poke to ERROR_STATUS register failed")
		reg_block.error_status.sample_values();

		{w_data[4], w_data[3], w_data[2], w_data[1], w_data[0]} = 5'b11111;

		// Frontdoor write to register
		`uvm_info(get_type_name(), $sformatf("Writing to ERROR_STATUS = %b", w_data), UVM_MEDIUM)
		reg_block.error_status.write(status, w_data, UVM_BACKDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to ERROR_STATUS register failed")

		bus_error = (w_data[0]==1)?'b0:'b1;
		timeout_error = (w_data[1]==1)?'b0:'b1;
		alignment_error = (w_data[2]==1)?'b0:'b1;
		overflow_error = (w_data[3]==1)?'b0:'b1;
		underflow_error = (w_data[4]==1)?'b0:'b1;
		Reserved = w_data[7:5];
		error_code = w_data[15:8];
		error_addr_offset = w_data[31:16];
		// Frontdoor Read from the register
		reg_block.error_status.read(status, r_data, UVM_BACKDOOR); 
		`uvm_info(get_name(), $sformatf("Read from CONFIG register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from CONFIG register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Expected Value\tRead Value");
		$display("bus_error\t        %0h\t           %0h", bus_error, r_data[1:0]);
		$display("timeout_error\t        %0h\t\t   %0h", timeout_error, r_data[2]);
		$display("alignment_error\t%0h\t           %0h", alignment_error, r_data[3]);
		$display("overflow_error\t%0h\t           %0h", overflow_error, r_data[5:4]);
		$display("underflow_error\t%0h\t           %0h", underflow_error, r_data[7:6]);
		$display("Reserved\t        %0h\t\t   %0h\t (NOT COMPARED)", Reserved, r_data[31:9]);
		$display("error_code\t        %0h\t           %0h", error_code, r_data[15:8]);
		$display("error_addr_offset    %0h\t           %0h", error_addr_offset, r_data[31:16]);

		// Check the written and read values
		if(bus_error === r_data[0])
			`uvm_info(get_type_name()," bus_error field of ERROR_STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name()," bus_error field of ERROR_STATUS register test FAILED",UVM_NONE)

		if(timeout_error === r_data[1])
			`uvm_info(get_type_name(),"timeout_error field of ERROR_STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"timeout_error field of ERROR_STATUS register test FAILED",UVM_NONE)

		if(alignment_error === r_data[2])
			`uvm_info(get_type_name(),"alignment_error field of ERROR_STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"alignment_error field of ERROR_STATUS register test FAILED",UVM_NONE)

		if(overflow_error === r_data[3])
			`uvm_info(get_type_name(),"overflow_error field of ERROR_STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"overflow_error field of ERROR_STATUS register test FAILED",UVM_NONE)
		if(underflow_error === r_data[4])
			`uvm_info(get_type_name(),"underflow_error field of ERROR_STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"underflow_error field of ERROR_STATUS register test FAILED",UVM_NONE)

		if(error_code === r_data[15:8])
			`uvm_info(get_type_name(),"error_code field of ERROR_STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"error_code field of ERROR_STATUS register test FAILED",UVM_NONE)

		if(error_addr_offset === r_data[31:16])
			`uvm_info(get_type_name(),"error_addr_offset field of ERROR_STATUS register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"error_addr_offset field of ERROR_STATUS register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_error_status_sequence
//--------------------------------------------------------------------------------------------------------------------------
// Regression
class dma_regression_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block reg_block;

	dma_intr_sequence intr_seq;
	dma_ctrl_sequence ctrl_seq;
	dma_io_addr_sequence io_addr_seq;
	dma_mem_addr_sequence mem_addr_seq;
	dma_extra_info_sequence extra_info_seq;
	dma_status_sequence status_seq;
	dma_transfer_count_sequence transfer_count_seq;
	dma_descriptor_addr_sequence descriptor_addr_seq;
	dma_configur_sequence configur_seq;
	dma_error_status_sequence error_status_seq;

	`uvm_object_utils(dma_regression_sequence)

	function new(string name = "dma_regression_sequence");
		super.new(name);
	endfunction : new

	task body();
		intr_seq = dma_intr_sequence::type_id::create("intr_seq");
		ctrl_seq = dma_ctrl_sequence::type_id::create("ctrl_seq");
		io_addr_seq = dma_io_addr_sequence::type_id::create("io_addr_seq");
		mem_addr_seq = dma_mem_addr_sequence::type_id::create("mem_addr_seq");
		extra_info_seq = dma_extra_info_sequence::type_id::create("extra_info_seq");
		status_seq = dma_status_sequence::type_id::create("status_seq");
		transfer_count_seq = dma_transfer_count_sequence::type_id::create("transfer_count_seq");
		descriptor_addr_seq = dma_descriptor_addr_sequence::type_id::create("descriptor_addr_seq");
		configur_seq = dma_configur_sequence::type_id::create("configur_seq");
		error_status_seq = dma_error_status_sequence::type_id::create("error_status_seq");

		intr_seq.reg_block = reg_block;
		ctrl_seq.reg_block = reg_block;
		io_addr_seq.reg_block = reg_block;
		mem_addr_seq.reg_block = reg_block;
		extra_info_seq.reg_block = reg_block;
		status_seq.reg_block = reg_block;
		transfer_count_seq.reg_block = reg_block;
		descriptor_addr_seq.reg_block = reg_block;
		configur_seq.reg_block = reg_block;
		error_status_seq.reg_block = reg_block;

		repeat(3)
		begin
			intr_seq.start(m_sequencer);
			$display("#####################################################################################################################################");
		end

		repeat(3)
		begin
			ctrl_seq.start(m_sequencer);
			$display("#####################################################################################################################################");
		end

			io_addr_seq.start(m_sequencer);
			$display("#####################################################################################################################################");
		mem_addr_seq.start(m_sequencer);
		$display("#####################################################################################################################################");
		extra_info_seq.start(m_sequencer);
		$display("#####################################################################################################################################");

		repeat(3)
		begin
			status_seq.start(m_sequencer);
			$display("#####################################################################################################################################");
		end

		repeat(3)
		transfer_count_seq.start(m_sequencer);
		$display("#####################################################################################################################################");
		descriptor_addr_seq.start(m_sequencer);
		$display("#####################################################################################################################################");

		repeat(4)
		begin
			configur_seq.start(m_sequencer);
			$display("#####################################################################################################################################");
		end

		repeat(4)
		begin
			error_status_seq.start(m_sequencer);
			$display("#####################################################################################################################################");
		end
	endtask : body

endclass : dma_regression_sequence
