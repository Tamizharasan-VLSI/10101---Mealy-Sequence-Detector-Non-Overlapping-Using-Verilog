module tb;
reg clk,rst,data_in;
wire data_out;
integer i;
fsm_moore_10101 dut (clk,rst,data_in,data_out);

always #5 clk = ~clk;

task reset;
begin
rst = 1;
#10;
rst = 0;
end
endtask

task seq;
reg [10:0]pattern = 10'b1010110011;
begin
for(i = 10;i >=0 ;i = i-1)begin
@(posedge clk);
data_in = pattern[i];
#10;
end
end
endtask

task random;
begin
for(i = 0;i < 20 ;i = i+1)begin
@(posedge clk);
data_in = $random;
#10;
end
end
endtask

task ran;
begin
repeat (50)begin;
@(posedge clk);
data_in = $urandom;
#10;
end
end
endtask


initial begin
$dumpfile("dump.vcd");
    $dumpvars(0, tb);
    $monitor("time=%0t | data_in=%b | data_out=%b ", 
             $time, data_in, data_out);
clk=1;
reset();
seq();
#10;
reset();
random();
#10;
reset ();
ran ();
#10; $finish;
end

endmodule








