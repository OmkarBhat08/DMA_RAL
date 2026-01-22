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
		w_data[31:0] = $urandom(); 

		// Poke random value to register
		`uvm_info("POKING_DATA", $sformatf("intr = %0d", w_data), UVM_MEDIUM)
		reg_block.intr.poke(status, w_data);
		intr_status = w_data[15:0];
		
		//Re randomize to later check for poke
		w_data[31:0] = $urandom(); 
		reg_block.intr.write(status, w_data, UVM_BACKDOOR);
		intr_mask = w_data[31:16];

		// Backdoor Read the value from the register
		reg_block.intr.read(status, r_data, UVM_BACKDOOR); 
		`uvm_info(get_name(), $sformatf("Read from INTR register: %0h", r_data), UVM_MEDIUM) 
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
		bit [14:0] Reserved_expected, Reserved_received;

		//w_data = $urandom();
		w_data[0] = 1'b1;
		w_data[15:1] = $urandom(); 
		w_data[16] = 1'b1;
		w_data[31:17] = $urandom(); 

		// Poke random value to register
		`uvm_info("POKING_DATA", $sformatf("CTRL = %0d", w_data), UVM_MEDIUM)
		reg_block.intr.poke(status, w_data);
		Reserved_expected = w_data[31:17];	

		// Write value to register
		w_data[0] = 1'b1;
		w_data[15:1] = $urandom(); 
		w_data[16] = 1'b1;
		w_data[31:17] = $urandom(); 
		`uvm_info(get_type_name(), $sformatf("Writing to CTRL = %0h", w_data), UVM_MEDIUM)
		reg_block.ctrl.write(status, w_data, UVM_BACKDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to CTRL register failed")

	/*
		// Backdoor Read the Reserved value from the register
		reg_block.intr.peek(status, r_data); 
		`uvm_info(get_name(), $sformatf("Read from CTRL register: %0h", r_data), UVM_MEDIUM) 
		Reserved_received = r_data[31:17];
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from CTRL register failed")
	*/

		// Backdoor Read the value from the register
		reg_block.intr.read(status, r_data, UVM_BACKDOOR); 
		`uvm_info(get_name(), $sformatf("Read from CTRL register: %0h", r_data), UVM_MEDIUM) 
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from CTRL register failed")

		// Display values
		$display("*****************************************CHECK*****************************************");
		$display("Field\t\t   Write Value\tRead Value");
		$display("start_dma\t    %0h\t  %0h",w_data[0], r_data[0]);
		$display("w_count\t    %0h\t  %0h",w_data[15:1], r_data[15:1]);
		$display("io_mem\t    %0h\t  %0h",w_data[16], r_data[16]);
		$display("Reserved\t    %0h\t  %0h",Reserved_expected, Reserved_received);

		// Check the written and read values
		if(w_data == r_data)
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
		bit [`DATA_WIDTH-1:0] w_data , r_data, mirror;
		w_data = $urandom(); 
		// Write random value to register
		`uvm_info(get_type_name(), $sformatf("Writing to io_addr = %0h", w_data), UVM_MEDIUM)
		reg_block.io_addr.write(status, w_data, UVM_FRONTDOOR);
		if(status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to IO_ADDR register failed")

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
		if(w_data == r_data)
			`uvm_info(get_type_name(),"IO_ADDR register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"IO_ADDR register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_io_addr_sequence
