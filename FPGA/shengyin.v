//-----------------------------------------------------------
//       �������������ܣ��������ͱ�����
//-----------------------------------------------------------
module shengyin(
               input [4:0] keycode ,
			   input key_ready,
			   input clk,
			   input  [2:0] flag_time,
			   output reg k1, 
			   input flag_b,
			   output reg bee
               );
reg  [15:0]count_05; 
reg  [15:0]count_20;          
reg  [15:0]cnt1ms;
reg clk1000Hz;
always@(posedge clk)                            
    begin
    if(cnt1ms==16'd12500)
        begin
            cnt1ms<=16'b0;
            clk1000Hz<=~clk1000Hz;
        end
    else
        cnt1ms=cnt1ms+16'b1;
    end 
always@(posedge clk1000Hz)                     
begin
	if(key_ready==1)
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
	  begin count_20=10000; end
end  
always@(posedge clk1000Hz)                    
begin
	if((count_20!=0)||(count_05!=0))
	begin bee=~bee;end
	else bee=1;
end
endmodule