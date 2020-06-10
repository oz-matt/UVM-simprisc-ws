`ifndef MDRIVER_INT
`define MDRIVER_INT

interface mdriver_int #(
		parameter integer C_AXI_DATA_WIDTH	= 32,
		parameter integer C_AXI_ADDR_WIDTH	= 9
)(
 input logic clk,
  input logic nreset
);
	
	logic[C_AXI_ADDR_WIDTH-1:0]					si_address;
	logic[C_AXI_DATA_WIDTH-1:0]					si_data;
	logic[C_AXI_DATA_WIDTH-1:0]					so_data;
	logic										we;
  	logic										exec;
    logic										fin;
  
    task execute_write(byte addr, int data);
    we <= 1;
      si_address <= addr;
      si_data <= data;
      exec <= 1; 
      @(posedge fin);
      exec <= 0;
      @(negedge fin);
  endtask
  
  task execute_read(byte addr);
    we <= 0;
      si_address <= addr;
      exec <= 1;
      @(posedge fin);
      exec <= 0;
      @(negedge fin);
  endtask
  
	
	modport master
	(
		input									clk,
		input									nreset,
		output 									si_address,
		output 									si_data,
		input 									so_data,
		output 									we,
        output									exec,
        input									fin
	);
	
	modport slave
	(
		input									clk,
		input									nreset,
		input 									si_address,
		input 									si_data,
		output 									so_data,
		input 									we,
        input									exec,
        output									fin
	);
  
  
	
endinterface : mdriver_int

`endif

`ifndef AXI_LITE_INT
`define AXI_LITE_INT

interface axilite_int #(
		parameter integer C_AXI_DATA_WIDTH	= 32,
		parameter integer C_AXI_ADDR_WIDTH	= 9
	);
	
	
	logic  								AXI_ACLK;
	logic  								AXI_ARESETN;
	
	// Read address    M -> S
	logic [C_AXI_ADDR_WIDTH-1 : 0] 		AXI_ARADDR;
	logic [2:0] 						AXI_ARPROT;
	logic  								AXI_ARVALID;
	logic  								AXI_ARREADY;
	
	// Read data    S -> M
	logic [C_AXI_DATA_WIDTH-1 : 0] 		AXI_RDATA;
	logic [1:0] 						AXI_RRESP;
	logic  								AXI_RVALID;
	logic  								AXI_RREADY;
	
	// Write address   M -> S
	logic [C_AXI_ADDR_WIDTH-1 : 0] 		AXI_AWADDR;
	logic [2:0] 						AXI_AWPROT;
	logic  								AXI_AWVALID;
	logic  								AXI_AWREADY;
	
	// Write data    M -> S
	logic [C_AXI_DATA_WIDTH-1 : 0] 		AXI_WDATA;
	logic [(C_AXI_DATA_WIDTH/8)-1:0] 	AXI_WSTRB;
	logic  								AXI_WVALID;
	logic  								AXI_WREADY;
	
	// Write response    S -> M
	logic [1:0] 						AXI_BRESP;
	logic  								AXI_BVALID;
	logic  								AXI_BREADY;
	
	
	modport master(
		input                               AXI_ACLK,
		input                               AXI_ARESETN,

		// Read address    M -> S
		output     							AXI_ARADDR,
		output                         		AXI_ARPROT,
		output                              AXI_ARVALID,
		input                               AXI_ARREADY,

		// Read data    S -> M
		input    							AXI_RDATA,
		input                        		AXI_RRESP,
		input                               AXI_RVALID,
		output                              AXI_RREADY,

		// Write address   M -> S
		output    							AXI_AWADDR,
		output                         		AXI_AWPROT,
		output                              AXI_AWVALID,
		input                               AXI_AWREADY,

		// Write data    M -> S
		output    							AXI_WDATA,
		output   							AXI_WSTRB,
		output                              AXI_WVALID,
		input                               AXI_WREADY,

		// Write response    S -> M  
		input                         		AXI_BRESP,
		input                               AXI_BVALID,
		output                              AXI_BREADY

	);
	modport slave(
		input                               AXI_ACLK,
		input                               AXI_ARESETN,

		// Read address    M -> S
		input     							AXI_ARADDR,
		input                         		AXI_ARPROT,
		input                               AXI_ARVALID,
		output                              AXI_ARREADY,

		// Read data    S -> M
		output    							AXI_RDATA,
		output                        		AXI_RRESP,
		output                              AXI_RVALID,
		input                               AXI_RREADY,

		// Write address   M -> S
		input    							AXI_AWADDR,
		input                         		AXI_AWPROT,
		input                               AXI_AWVALID,
		output                              AXI_AWREADY,

		// Write data    M -> S
		input    							AXI_WDATA,
		input   							AXI_WSTRB,
		input                               AXI_WVALID,
		output                              AXI_WREADY,

		// Write response    S -> M
		output                         		AXI_BRESP,
		output                              AXI_BVALID,
		input                               AXI_BREADY

		);
  
endinterface : axilite_int

    
`endif
module memslave(axilite_int.slave io, aximem.axim memaxi);

	logic valid_read_received;
	logic write_request_permitted;

	logic[31:0] mem[255:0];

	always_comb begin
		valid_read_received = io.AXI_ARVALID && io.AXI_ARREADY;
		write_request_permitted = vif.AXI_AWVALID && vif.AXI_AWREADY && vif.AXI_WVALID && vif.AXI_WREADY;
    end

	always_ff @ (posedge io.AXI_ACLK or negedge io.AXI_ARESETN) begin
		if (!io.AXI_ARESETN)
			io.AXI_ARREADY <= 0;
		else if (valid_read_received)
			io.AXI_ARREADY <= 0;
		else if (io.AXI_ARVALID)
			io.AXI_ARREADY <= 1;
		else
			io.AXI_ARREADY <= 0;
	end
	always_ff @ (posedge io.AXI_ACLK or negedge io.AXI_ARESETN) begin
		if (!io.AXI_ARESETN)
			io.AXI_AWREADY <= 0;
		else if (write_request_permitted)
			io.AXI_AWREADY <= 0;
		else if (io.AXI_AWVALID)
			io.AXI_AWREADY <= 1;
		else
			io.AXI_AWREADY <= 0;
	end
	always_ff @ (posedge io.AXI_ACLK or negedge io.AXI_ARESETN) begin
		if (!io.AXI_ARESETN)
			io.AXI_WREADY <= 0;
		else if (write_request_permitted)
			io.AXI_WREADY <= 0;
		else if (io.AXI_WVALID)
			io.AXI_WREADY <= 1;
		else
			io.AXI_WREADY <= 0;
	end

	always_ff @ (posedge io.AXI_ACLK or negedge io.AXI_ARESETN) begin
		if (!io.AXI_ARESETN)
			io.AXI_RVALID <= 0;
		else if (valid_read_received)
			io.AXI_RVALID <= 1;
		else
			io.AXI_RVALID <= 0;
	end

	always_ff @ (posedge io.AXI_ACLK or negedge io.AXI_ARESETN) begin
		if (!io.AXI_ARESETN)
			io.AXI_BVALID <= 0;
		else if (write_request_permitted)
			io.AXI_BVALID <= 1;
		else
			io.AXI_BVALID <= 0;
	end

	always_ff @ (posedge io.AXI_ACLK or negedge io.AXI_ARESETN) begin
		if (!io.AXI_ARESETN)
			io.AXI_RDATA <= 0;
		else if (valid_read_received)
			io.AXI_RDATA <= mem[io.AXI_ARADDR];
		else
			io.AXI_RDATA <= 0;
	end

  always_ff @(posedge write_request_permitted) begin
	mem[io.AXI_AWADDR] <= io.AXI_WDATA;
    memaxi.axi_mem_w <= 1;
    memaxi.axi_mem_addr <= io.AXI_AWADDR;
    memaxi.axi_mem_data <= io.AXI_WDATA;
  end

endmodule

module master_wrapper(mdriver_int.slave io, aximem.axim mem);

  axilite_int#(32,9) vif();

	typedef enum integer {
		IDLE,
		EXECUTING_READ,
		EXECUTING_WRITE,
		WAITING_READ,
		WAITING_WRITE
	} pstate_t;

	pstate_t pstate;

  memslave memslave_inst(.io(vif.slave), .memaxi(mem));
  
  logic[31:0] adcdata;
  
  adc_handoff adc_inst(.clk(io.clk), .adcout(adcdata));

	integer local_data;
	logic   ready_for_data;
	logic   ready_for_write_response;
	logic   valid_read_data_received;
	logic   valid_write_response_received;

	logic finread;
	logic finwrite;

	assign vif.AXI_ACLK = io.clk;
	assign vif.AXI_ARESETN = io.nreset;
	assign io.so_data = local_data;
	assign io.fin = io.we ? finwrite : finread;
	assign vif.AXI_RREADY = ready_for_data;
	assign vif.AXI_BREADY = ready_for_write_response;

	always_ff @(posedge io.clk or negedge io.nreset) begin
		if (!io.nreset) begin
			vif.AXI_ARVALID <= 0;
			vif.AXI_AWVALID <= 0;
			vif.AXI_WVALID <= 0;
            pstate <= IDLE;
		end
		else begin
			case (pstate)
				IDLE : begin
					vif.AXI_ARVALID <= 0;
					vif.AXI_AWVALID <= 0;
					vif.AXI_WVALID <= 0;
					if (io.exec)
						pstate <= io.we ? EXECUTING_WRITE : EXECUTING_READ;
				end

				EXECUTING_READ : begin
					vif.AXI_ARVALID <= 1;
					if(vif.AXI_ARVALID && vif.AXI_ARREADY) begin
						vif.AXI_ARVALID <= 0;
						pstate <= WAITING_READ;
					end
				end

				EXECUTING_WRITE : begin
					vif.AXI_AWVALID <= 1;
					vif.AXI_WVALID <= 1;
					if(vif.AXI_AWVALID && vif.AXI_AWREADY && vif.AXI_WVALID && vif.AXI_WREADY) begin
						vif.AXI_AWVALID <= 0;
						vif.AXI_WVALID <= 0;
						pstate <= WAITING_WRITE;
					end
				end

				WAITING_READ : begin
					if (finread) pstate <= IDLE;
				end

				WAITING_WRITE : begin
					if (finwrite) pstate <= IDLE;
				end

			endcase
		end
	end

	always_comb begin
		valid_read_data_received = vif.AXI_RVALID && vif.AXI_RREADY;
		valid_write_response_received = vif.AXI_BVALID && vif.AXI_BREADY;
	end

	assign vif.AXI_ARADDR = (vif.AXI_ARVALID && (pstate == EXECUTING_READ)) ? io.si_address : 0;

	assign vif.AXI_AWADDR = (vif.AXI_AWVALID && (pstate == EXECUTING_WRITE)) ? io.si_address : 0;

	assign vif.AXI_WDATA = (vif.AXI_WVALID && (pstate == EXECUTING_WRITE)) ? io.si_data : 0;

	always_ff @ (posedge io.clk or negedge io.nreset) begin
      if (!io.nreset) begin
        finread <= 0;
			ready_for_data <= 0;
        local_data <= 0;
      end
		else if (finread) begin
			finread <= 0;
			ready_for_data <= 1;
		end
		else if (valid_read_data_received) begin
			local_data <= vif.AXI_RDATA;
			ready_for_data <= 0;
			finread <= 1;
		end
		else if (vif.AXI_RVALID)
			ready_for_data <= 1;
		else
			ready_for_data <= 1;
	end

	always_ff @ (posedge io.clk or negedge io.nreset) begin
      if (!io.nreset) begin
			ready_for_write_response <= 0;
         finwrite <= 0;
      end
		else if (finwrite) begin
			ready_for_write_response <= 1;
			finwrite <= 0;
		end
		else if (valid_write_response_received) begin
			ready_for_write_response <= 0;
			finwrite <= 1;
		end
		else if (vif.AXI_BVALID)
			ready_for_write_response <= 1;
		else
			ready_for_write_response <= 1;
	end

endmodule

