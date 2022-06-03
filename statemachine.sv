module statemachine(clk, rst, left, right, brake, hazard, pattern);
  input clk, rst, left, right, brake, hazard;
  output reg[5:0] pattern;
  reg[3:0] state, nextState;
  
  parameter ALL_OFF = 4'b0000, ALL_ON = 4'b0001, 
            L_0 = 4'b0010, L_1 = 4'b0011, L_2 = 4'b0100,
            BL_0 = 4'b0101, BL_1 = 4'b0110,
            R_0 = 4'b0111,  R_1 = 4'b1000, R_2 = 4'b1001,
            BR_0 = 4'b1010, BR_1 = 4'b1011;
  
// implementing transition diagram
always@(*) begin
    if (rst) nextState = ALL_OFF; // Highest priority: reset
    else if (brake && (left ^ right)) begin // If brake while signal
          if (left) begin
            case(state)
              R_2 : nextState = BL_0;
              BL_0 : nextState = BL_1;
              BL_1 : nextState = ALL_ON;
              ALL_ON : nextState = R_2;
              default : nextState = R_2;
            endcase
          end
          else begin
            case(state)
              L_2 : nextState = BR_0;
              BR_0 : nextState = BR_1;
              BR_1 : nextState = ALL_ON;
              ALL_ON : nextState = L_2;
              default : nextState = L_2;
            endcase
          end
    end
    else if (brake) begin // If brake
        nextState = ALL_ON;
    end
    else if (hazard || (left && right)) begin // Hazard OR both signals on
      case(state)
        ALL_ON : nextState = ALL_OFF;
        default : nextState = ALL_ON;
      endcase
    end
    else if (left ^ right) begin // Left XOR Right
      if (left) begin
        case(state)
          ALL_OFF : nextState= L_0;
          L_0 : nextState = L_1;
          L_1 : nextState = L_2;
          L_2 : nextState = ALL_OFF;
          default : nextState = ALL_OFF;
        endcase
      end
      else if (right) begin
        case(state)
          ALL_OFF : nextState = R_0;
          R_0 : nextState = R_1;
          R_1 : nextState = R_2;
          R_2 : nextState = ALL_OFF;
          default : nextState = ALL_OFF;
        endcase
      end
    end
end

// assigning output to states
always@(*) begin
  case(state)
    ALL_OFF : pattern = 6'b000000;
    ALL_ON :  pattern = 6'b111111;
    L_0 :     pattern = 6'b001000;
    L_1 :     pattern = 6'b011000;
    L_2 :     pattern = 6'b111000;
    BL_0 :    pattern = 6'b001111;
    BL_1 :    pattern = 6'b011111;
    R_0 :     pattern = 6'b000100;
    R_1 :     pattern = 6'b000110;
    R_2 :     pattern = 6'b000111;
    BR_0 :    pattern = 6'b111100;
    BR_1 :    pattern = 6'b111110;
    //default:  pattern = 6'b000000;
  endcase
end

always@(posedge clk) state <= nextState;
endmodule
