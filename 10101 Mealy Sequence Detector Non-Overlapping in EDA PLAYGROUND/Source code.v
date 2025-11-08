module mealyfsm(
  input clk,rst,datain,
  output reg dataout);
  
  parameter s0 = 3'b000,
  s1 = 3'b001,
  s2 = 3'b010,
  s3 = 3'b011,
  s4 = 3'b100;
  
  reg [4:0] current,nxt;
  
  always@ (posedge clk or posedge rst)begin
    if(rst)
      current <= s0;
    else
      current <= nxt;
  end
  
  
  always@(*)begin
    dataout = 1'b0;
    
    case(current)
      s0: begin
        if(datain)
             nxt = s1;//1
        else
          nxt = s0;
      end
      
      s1: begin //10
        if(!datain)
          nxt = s2;
        else
          nxt = s1;
      end
      
      s2: begin  //101
        if(datain)
          nxt = s3;
        else
          nxt= s0;
      end
      
      s3: begin  //1010
        if(!datain)
          nxt = s4;
        else 
          nxt = s1;
      end
      
      
        s4: begin   //10101
          if(datain)begin
            dataout = 1;
            nxt = s1;
        end
      else begin
            nxt = s0;
      end
        end
          endcase
        end
      endmodule