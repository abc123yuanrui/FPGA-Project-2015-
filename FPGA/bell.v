module bell(cmd,clk,flag_time,k1,clock,bee);
input cmd;
input clk;
input  [2:0] flag_time;
output k1; 
input clock;
output reg bee;
              
reg k1;
reg  [15:0]count_05; 
reg  [15:0]count_20;          
reg  [15:0]count;
reg clk1000Hz;
reg [25:0]k2;  //k2jilu ring time 
initial                                     
 begin
        k2=25'd500;
end
always@(posedge clk)                            
    begin
    if(count==16'd12500)
        begin
            count<=16'b0;
            clk1000Hz<=~clk1000Hz;
        end
    else
        count=count+16'b1;
    end 
always@(posedge clk1000Hz)                     
begin
	if(cmd==1)
	begin count_05=100; end 
	else if (count_05!=0)
	begin count_05=count_05-15'h1; end
end
always@(posedge clk1000Hz)                     
begin
	
	 if (count_20!=0)
	 begin 
		count_20=count_20-1; k1=1 ;
		if (count_20==0)
		begin k1=0 ; end
	 end
	 else if((flag_time[2]==1)&&(k1==0))
	  begin count_20=k2; k2=k2+500;end
end  
always@(posedge clk1000Hz)                    
begin
	if((count_20!=0)||(count_05!=0))
	begin bee=~bee;end
	else bee=1;
end
endmodule