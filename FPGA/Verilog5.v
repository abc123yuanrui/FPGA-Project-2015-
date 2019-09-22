module  password(
			   input clk,         
                           input [4:0] keycode ,
			   output reg flag_b,
			   input key_ready,
			   input k1,         
			   output reg led_1,
			   output reg led_2,
			   output reg led_3,
			   output reg change_lemp,
			   output reg change_lemp1, 
			   output reg [2:0] flag_time
               );
reg [4:0] password_1;
reg [4:0] password_2;
reg [4:0] password_3;
reg [4:0] password_4;

reg  [15:0]count_15;
reg k2;
reg  [15:0]cnt1ms;

reg clk1000Hz;
initial                                     
 begin
     count_15=0;   
end
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
 
initial                                    
 begin
        password_1=8;
        password_2=8;
        password_3=8;
        password_4=8;
        flag_time=1;
end

reg [4:0] password_input_1;     
reg [4:0] password_input_2;
reg [4:0] password_input_3;
reg [4:0] password_input_4;

reg [4:0] password_change_1;     
reg [4:0] password_change_2;
reg [4:0] password_change_3;
reg [4:0] password_change_4;

always @( negedge key_ready)
begin
	
	 if(count_15==1)begin flag_time=flag_time+1;k2=1; end
	 if(keycode<10)                             
	begin
		password_input_4<=keycode;
	    password_input_3<=password_input_4;
	    password_input_2<=password_input_3;
	    password_input_1<=password_input_2;
	end
	else if(keycode==5'hd)
		begin 
			flag_b=~flag_b;
			if(flag_b==0)
			begin
			change_lemp=0;
			flag_time=1;
			change_lemp1=0;
			k2=0;	
			end
	    end
	else if(k1==1)begin flag_time=1;end
	else if(keycode==5'hb&&flag_b==0)  

	begin
        if((password_input_1==password_1)&&(password_input_2==password_2)&&

(password_input_3==password_3)&&(password_input_4==password_4))
        begin flag_b=1;end
        else
        begin
        flag_b=0;
        flag_time=flag_time+1;
        end
    end
    else if(keycode==5'hc&&flag_b==1)     
    begin
		change_lemp1=1;
		password_change_1 <=password_input_1;
		password_change_2 <=password_input_2;
		password_change_3 <=password_input_3;
		password_change_4 <=password_input_4;
    end
    else if(keycode==5'hb&&flag_b==1)      
   begin	    
	    if((password_change_1==password_input_1)&&

(password_change_2==password_input_2)&&(password_change_3==password_input_3)&&

(password_change_4==password_input_4))
	    begin
			change_lemp=1;
			password_1<=password_change_1 ;
			password_2<=password_change_2 ;
			password_3<=password_change_3 ;
			password_4<=password_change_4 ;
	    end
    end
 end

always@(posedge clk1000Hz)         
begin
	if(k2==1)count_15=0;
    else if((flag_b==0)&&(keycode==5'hb))
	begin count_15=15000; end 
	 else if ((count_15!=1))
	 begin 
		count_15=count_15-1;
		if(count_15==0)
		begin 
			
        end	
    end
end 
              
 

 
 
 always @(negedge clk1000Hz)           //����ʧ�ܴ�����ʾ
 begin
if (flag_time==1)begin led_1=1;led_2=1;led_3=1;end
else if (flag_time==2)begin led_1=0;led_2=1;led_3=1;end
else if (flag_time==3)begin led_1=0;led_2=0;led_3=1;end
else begin led_1=~led_1;led_2=~led_2;led_3=~led_3;end
end
     
        
endmodule	