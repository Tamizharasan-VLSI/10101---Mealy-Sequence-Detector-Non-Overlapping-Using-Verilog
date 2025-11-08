
module fsm_mealy_10101(
  input clk, rst, data_in,
  output reg data_out
);
  
  parameter s0 = 3'b000,  // idle/reset
            s1 = 3'b001,  // received 1
            s2 = 3'b010,  // received 10
            s3 = 3'b011,  // received 101
            s4 = 3'b100;  // received 1010
  
  reg [2:0] current_state, next_state;

  always @(posedge clk or posedge rst) begin
    if (rst)
      current_state <= s0;
    else
      current_state <= next_state;
  end

  always @(*) begin
     data_out = 1'b0;

    case (current_state)
      s0: begin
        if (data_in)
          next_state = s1;
        else
          next_state = s0;
      end

      s1: begin
        if (!data_in)
          next_state = s2;
        else
          next_state = s1;
      end

      s2: begin
        if (data_in)
          next_state = s3;
        else
          next_state = s0;
      end

      s3: begin
        if (!data_in)
          next_state = s4;
        else
          next_state = s1;
      end

      s4: begin
        if (data_in) begin
          next_state = s1;
          data_out = 1'b1;   // output 1 when full pattern "10101" is detected
        end
        else
          next_state = s0;
      end
    endcase
  end
endmodule


