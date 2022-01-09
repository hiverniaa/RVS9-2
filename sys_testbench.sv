`timescale 1ns / 1ps

module sys_testbench(

    );
    
    logic clk;
    logic rst;
    
    always #10 clk = ~clk;
    
    top_rv myDUT (.clk(clk),
                  . rst(rst));
    
    initial begin
        clk <= 0;
        rst <= 1;
        #100 rst <= 0;
        
        #1000 $finish;
   end 
endmodule
