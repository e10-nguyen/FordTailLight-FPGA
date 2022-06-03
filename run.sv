// run module will dim the activated light patterns by oscillating the on signals.
// off lights -> 50% on lights -> 100% on
module run(dimclk, runlight, patterns, lights);
  input dimclk, runlight;
  input reg[5:0] patterns;
  output reg[5:0] lights;
  reg toggle;
  always@(posedge dimclk) begin
    if (runlight)  begin
      toggle <= ~toggle;
      if (patterns[0] == 1) begin
        lights[0] <= 1'b1;
      end
      else begin
        lights[0] <= toggle;
      end
      if (patterns[1] == 1) begin
        lights[1] <= 1'b1;
      end
      else begin
        lights[1] <= toggle;
      end
      if (patterns[2] == 1) begin
        lights[2] <= 1'b1;
      end
      else begin
        lights[2] <= toggle;
      end
      if (patterns[3] == 1) begin
        lights[3] <= 1'b1;
      end
      else begin
        lights[3] <= toggle;
      end
      if (patterns[4] == 1) begin
        lights[4] <= 1'b1;
      end
      else begin
        lights[4] <= toggle;
      end
      if (patterns[5] == 1) begin
        lights[5] <= 1'b1;
      end
      else begin
        lights[5] <= toggle;
      end
      
  end
  else begin
    lights = patterns;
  end
end
    
endmodule
  
