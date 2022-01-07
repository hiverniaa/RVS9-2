`timescale 1ns / 1ps

module sys_testbench(

    );
    
    logic clk;
    
    always #10 clk = ~clk;
    
    top_rv myDUT (.clk(clk));
    
    initial begin
        clk <= 0;
        
        #100 $finish;
   end 
endmodule
