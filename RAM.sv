
  //  Xilinx Single Port Read First RAM
  //  This code implements a parameterizable single-port read-first memory where when data
  //  is written to the memory, the output reflects the prior contents of the memory location.
  //  If the output data is not needed during writes or the last read value is desired to be
  //  retained, it is suggested to set WRITE_MODE to NO_CHANGE as it is more power efficient.
  //  If a reset or enable is not necessary, it may be tied off or removed from the code.
  //  Modify the parameters for the desired RAM characteristics.
module RAM #(
  parameter RAM_WIDTH = 32,                  // Specify RAM data width
  parameter RAM_DEPTH = 1024,                  // Specify RAM depth (number of entries)
  parameter RAM_PERFORMANCE = "LOW_LATENCY", // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
  parameter INIT_FILE = "Test_mem.txt"                       // Specify name/location of RAM initialization file if using one (leave blank if not)
)(
  input  logic [clogb2(RAM_DEPTH-1)-1:0] addr,  // Address bus, width determined from RAM_DEPTH
  input  logic [RAM_WIDTH-1:0] din,           // RAM input data
  input  logic clk,                           // Clock
  input  logic we,                            // Write enable
  //input logic en,                            // RAM Enable, for additional power savings, disable port when not in use
  //input logic rst,                           // Output reset (does not affect memory contents)
  input  logic regce,                         // Output register enable
  output logic [RAM_WIDTH-1:0] dout                   // RAM output data
);
  logic [RAM_WIDTH-1:0] ram [RAM_DEPTH-1:0];
  logic [RAM_WIDTH-1:0] data = {RAM_WIDTH{1'b0}};

  // The following code either initializes the memory values to a specified file or to all zeros to match hardware
  generate
    if (INIT_FILE != "") begin: use_init_file
      initial
        $readmemb(INIT_FILE, ram, 0, RAM_DEPTH-1);
    end else begin: init_bram_to_zero
      integer ram_index;
      initial
        for (ram_index = 0; ram_index < RAM_DEPTH; ram_index = ram_index + 1)
          ram [ram_index] = {RAM_WIDTH{1'b0}};
    end
  endgenerate

  always @(posedge clk) begin
    //if (en) begin
      if (we)
        ram [addr] <= din;
      data <= ram [addr];
    //end
   end
  //  The following code generates HIGH_PERFORMANCE (use output register) or LOW_LATENCY (no output register)
  generate
    if (RAM_PERFORMANCE == "LOW_LATENCY") begin: no_output_register

      // The following is a 1 clock cycle read latency at the cost of a longer clock-to-out timing
       assign dout = ram[addr];

    end else begin: output_register

      // The following is a 2 clock cycle read latency with improve clock-to-out timing

      logic [RAM_WIDTH-1:0] douta_reg = {RAM_WIDTH{1'b0}};

      always @(posedge clk)
        //if (rst)
          //douta_reg <= {RAM_WIDTH{1'b0}};
        if (regce)
          douta_reg <= data;

      assign dout = ram[addr];

    end
  endgenerate

  //  The following function calculates the address width based on specified RAM depth
  function integer clogb2;
    input integer depth;
      for (clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
  endfunction
						
endmodule					

//YEETY
