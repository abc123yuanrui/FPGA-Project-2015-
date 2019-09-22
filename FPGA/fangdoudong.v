module Vibrate( clk,key_in,key_out);
input clk; 
input key_in;
output key_out;
reg [22:0] count_high;
reg [22:0] count_low;
reg key_reg;
assign key_out = key_reg;
always@( posedge clk )
if( key_in == 1'b0 )
 count_low <= count_low + 1;
else
 count_low <= 23'h 00_0000;
 
always@( posedge clk )
if( key_in == 1'b1 ) 
 count_high <= count_high +1;
else
 count_high <= 23'h 00_0000;
always@( posedge clk )
begin
 if( count_high == 23'h 25_0000 )
  key_reg <= 1'b1;
 else
  if( count_low == 23'h 25_0000 )
   key_reg <= 1'b0;
  else
   key_reg <= key_reg;
end
endmodule