module top();
	bit clk, rst_n;
	dma_interfs interfs(clk, rst_n);


	always 
		#5 clk = ~clk;

	initial
		clk = 0;

	initial
	begin
		uvm_config_db #(virtual dma_interfs)::set(null, "*", "vif", interfs); 
		rst_n = 1;
		#50 rst_n = 0; 
	end

	initial
	begin
		run_test();
		$finish;
	end

endmodule
