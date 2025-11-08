module tb;
  reg clk,rst,datain;
  wire dataout;
   integer i;
  
  mealyfsm dut (clk,rst,datain,dataout);
  
  always#5 clk =~clk;
  
  task reset;
    begin
      rst =1;
      #10;
      rst=0;
    end
  endtask
  
  task sequence_;
    reg [10:0] pattern = 10'b1101010100;
    begin
      for (i = 10; i >= 0; i = i - 1) begin
        @(posedge clk);
        datain = pattern[i];
        #10;
      end
    end
  endtask

  
  task random;
    begin
      repeat(20)begin
    @(posedge clk);
      datain=$random%2;
      #10;
    end
    end
  endtask
  
  initial begin
    $monitor("time=%0t,datain=%0b,dataout=%b",$time,  datain,  dataout);
    $dumpfile("dump.vcd");
    $dumpvars(0,tb);
    clk=1;
    reset();
    random();
    #10;
    reset();
    sequence_();
    #10;
    $finish;
  end
endmodule

