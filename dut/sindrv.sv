module sindrv(mdriver_int.master io);

  logic[7:0] raddr;
  bit wstate;
  bit loop_finished;
  
  wire[4:0] rand_5[1:0];
  wire[7:0] rand_byte;
  
  logic[7:0] adcdata[0:255];
  
  initial begin
    $readmemh("adc.data", adcdata);
  end
  
  genvar i;
  
  generate 
    for (i = 0; i < 2; i = i + 1) begin
      lfsr_5bit lfsr_insta(
        .clk(io.clk), 
        .nreset(io.nreset), 
        .data(rand_5[i]));
    end
  endgenerate
  
  assign rand_byte = {rand_5[0][3:0], rand_5[1][3:0]};
  
    always_ff @ (posedge io.clk or negedge io.nreset) begin
      if (!io.nreset)
        raddr <= 0;
      else begin
        raddr <= raddr + 1;
      end
    end

  always_ff @(posedge io.clk) begin
    if (!io.nreset)
	wstate <= 0;
	else begin
  if (io.fin)
	wstate <= 0;
  else
	wstate <= 1;
  end
end

  logic[7:0] curr_addr;
  logic[7:0] target_addr;
  logic[31:0] curr_data;
  logic[7:0] curr_data_loop_addr;
  
  always_comb
    curr_data = {adcdata[curr_data_loop_addr + 3],
                 adcdata[curr_data_loop_addr + 2],
                 adcdata[curr_data_loop_addr + 1],
                adcdata[curr_data_loop_addr]
    };
  
  always_ff @(posedge io.clk) begin
      if (!io.nreset) begin
        curr_addr <= 0;
        target_addr <= 0;
        curr_data_loop_addr <= 0;
        loop_finished <= 1;
      end else
      if (io.exec)begin
        if(loop_finished) begin
          curr_addr <= rand_byte;
          target_addr <= rand_byte;
          curr_data_loop_addr <= 0;
          loop_finished <= 0;
        end
        else begin
          if(curr_addr == target_addr - 1) 
            loop_finished <= 1;
          else begin
            curr_addr <= curr_addr + 4;
            curr_data_loop_addr <= curr_data_loop_addr + 4;
          end
        end
      end
  end
  
  always_ff @(posedge io.clk) begin
    if (!io.nreset);
	else begin
    case (wstate)
      0: begin
        io.we <= 1;
        io.si_address <= {1'b1, curr_addr};
        io.si_data <= curr_data;
        io.exec <= 1; 
      end
      1: begin
        io.exec <= 0; 
      end
    endcase
    end
  end
	
endmodule

