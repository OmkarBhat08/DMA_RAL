class dma_adapter extends uvm_adapter;
	`uvm_object_utils(dma_adapter)

	function new(string name = "dma_adapter");
		super.new(name);
	endfunction : new

	function uvm_sequence_item reg2bus(cont ref uvm_reg_bus_op rw);
		dma_sequence_item dma;    
		dma = dma_sequence_item::type_id::create("dma");
		dma.wr_en = (rw.kind == UVM_WRITE);
		dma.rd_en = (rw.kind == UVM_READ);
		dma.addr  = rw.addr;
		dma.wdata = rw.data;
		return dma
	endfunction : reg2bus

	function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
		dma_seq_item dma;
		assert($cast(dma, bus_item))
		if(dma.wr_en)
		begin
			rw.kind = UVM_WRITE;
			rw.data = dma.wdata;
		end

		if(dma.rd_en)
		begin
			rw.kind = UVM_READ;
			rw.data = dma.rdata;
		end
		rw.addr = dma.addr;
		rw.status = UVM_IS_OK;
	endfunction: bus2reg

endclass : dma_adapter 
