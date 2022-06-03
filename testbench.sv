// test bench for taillight.sv module
module testbench();
  reg clk, dimclk;
  parameter CLK = 10;
  parameter DIMCLK = 1; //
  
  always begin
    #(CLK) clk = ~clk;
  end
  always begin
    #(DIMCLK) dimclk = ~dimclk;
  end
  reg runlight, rst, left, right, brake, hazard;
  wire [5:0] lights;
  
  taillight tester(.clk(clk), .dimclk(dimclk), .runlight(runlight), .rst(rst), .left(left), .right(right), .brake(brake), .hazard(hazard), .lights(lights));
  
  initial begin
    clk = 0;
    dimclk = 0;

    runlight = 0;
    left = 0;
    right = 0;
    brake = 0;
    hazard = 0;
    rst = 1; // Demonstate reset behavior
    #(10*CLK*2);
    rst = 0; // wait 10 cycles
    brake = 1; // Demonstrate brake behavior
    #(10*CLK*2);
    runlight = 1; // run light on
    left = 1; // Brake + left
    #(2*CLK)
    runlight = 0;
    #(10*CLK*2);
    left = 0;
    right = 1; // Brake + right
    #(10*CLK*2);
    right = 0;
    brake = 0;
    hazard = 1;
    #(10*CLK*2);
    left = 1; // Hazard + left
    #(10*CLK*2);
    left = 0;
    right = 1; // Hazard + right
    #(10*CLK*2);
    hazard = 0;
    left = 1;
    // testing hazard with turn signals (right + left)
    #(10*CLK*2);
    right = 0;
    left = 1; // testing left signal
    #(8*CLK*2);
    right = 1;
    left = 0;
    #(11*CLK*2);
    right = 0;
    $stop;
  end
endmodule