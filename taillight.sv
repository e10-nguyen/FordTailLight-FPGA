module taillight(clk, dimclk, runlight, rst, left, right, brake, hazard, lights);
  input clk, dimclk, runlight, rst, left, right, brake, hazard;
  wire [5:0] pattern;
  output  reg[5:0] lights;
  statemachine foo(.clk(clk), .rst(rst), .left(left), .right(right), .brake(brake), .hazard(hazard), .pattern(pattern));
  run bar(.dimclk(dimclk), .runlight(runlight), .patterns(pattern), .lights(lights));
endmodule;
  
  