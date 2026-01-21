class dma_ctrl_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block regblock;
	`uvm_object_utils(dma_ctrl_sequence)

	function new(string name = "dma_ctrl_sequence");
		super.new(name, parent);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [DATA_WIDTH-1:0] w_data ,r_data, mirror;
		w_data[0] = 1'b1; 
		w_data[15:1] = 15'd16; 
		w_data[16] = 1'b1; 

		`uvm_info(get_type_name(), $sformatf("ctrl[31:17] = %0d | ctrl[16] = %0d | ctrl[15:1] = %0d | ctrl[0] = %0d", w_data[31:17], w_data[16], w_data[15:1], w_data[0]), UVM_MEDIUM)
		`uvm_info(WRITING_DATA, $sformatf("ctrl = %0d", w_data), UVM_MEDIUM)
		regblock.ctrl.write(status, w_data, UVM_FRONTDOOR);

		mirror = regblock.ctrl.get_mirrored_value();
	endtask : body

endclass : dma_ctrl_sequence
//--------------------------------------------------------------------------------------------------------------------------
// IO_ADDR_SEQ
class dma_io_addr_sequence extends uvm_sequence #(dma_sequence_item);
	dma_reg_block regblock;
	`uvm_object_utils(dma_io_addr_sequence)

	function new(string name = "dma_io_addr_sequence");
		super.new(name, parent);
	endfunction : new

	task body();
		uvm_status_e status; 
		bit [DATA_WIDTH-1:0] w_data ,r_data, mirror;
		w_data[0] = $urandom(); 

		// Write random value to register
		`uvm_info(get_type_name(), "Writing to io_addr = %0d", w_data, UVM_MEDIUM)
		regblock.io_addr.write(status, w_data, UVM_FRONTDOOR);
		if(uvm_status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Writing to IO_ADDR register failed")
		
		// get the mirror value to check for successful write
		mirror = regblock.io_addr.get_mirrored_value(); 
		`uvm_info(WRITE_MIRROR_PASS, $sformatf("IO_ADDR mirrored = %0d", mirror), UVM_MEDIUM)

		// Read the value from the register
		regblock.io_addr.read(status, r_data, UVM_FRONTDOOR); 
		`uvm_info(get_type_name(), $sformatf("Read from IO_ADDR register: %0d", r_data), UVM_MEDIUM) 
		if(uvm_status != UVM_IS_OK)
			`uvm_error(get_type_name(), "Reading from IO_ADDR register failed")

		// Check the written and read values
		if(w_data == w_data)
			`uvm_info(get_type_name(),"IO_ADDR register test PASSED",UVM_NONE)
		else	
			`uvm_info(get_type_name(),"IO_ADDR register test FAILED",UVM_NONE)
	endtask : body

endclass : dma_io_addr_sequence
