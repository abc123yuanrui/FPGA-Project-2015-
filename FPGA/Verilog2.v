module jianpan(
					clk,
					inrow,outcol,//行输入，列读出
					key_value,//键值
					key_ready,//按键标志位
					lemp,lemp_0,lemp_1,lemp_2,lemp_3,lemp_4,lemp_5,lemp_6,lemp_7,lemp_8,lemp_9//键盘指示灯
					
				);

input   clk;                            //时钟25mhz
input   [3:0]   inrow;                  
output  [3:0]   outcol;                 
output  [4:0]   key_value;              
output  key_ready;                      
output reg lemp;
output reg lemp_0;
output reg lemp_1;
output reg lemp_2;
output reg lemp_3;
output reg lemp_4;
output reg lemp_5;
output reg lemp_6;
output reg lemp_7;
output reg lemp_8;
output reg lemp_9;
reg     clock;                          
reg     clock_2;                          
reg     clock_3;  
reg     key_flag;                       
reg     jud_flag;                       
reg     [3:0]   col;                    
reg     [3:0]   inrow_reg;             
reg     [3:0]   outcol_reg;             
reg     [2:0]   state;                  
reg     [4:0]   key_value;              
reg     [15:0]  count;
reg     [15:0]  count_2;
reg     [15:0]  count_3;
reg     [30:0]  count_4;
reg     [7:0]   keynum_1;              
reg     [7:0]   key_num0;             


always@(posedge clk)                    
begin
    count<=count+1;
    if(count>=15'd500000)                          
    begin
        clock<=~clock;
        count<=0;                         
    end
end


always@(posedge clock)
begin
case(state)
    0:                                        
    begin
        col<=4'b0000;                            
        key_flag<=1'b0;
        if(inrow!=4'b1111)                      
        begin
            state<=1;
            col<=4'b1110;                      
        end
        else state<=0;                            
    end
    1:
    begin
        if(inrow!=4'b1111)
        begin
            state<=5;                              
        end     
        else
        begin
            state<=2;
            col<=4'b1101;
        end
    end
    2:
    begin
        if(inrow!=4'b1111)
        begin
            state<=5;
        end     
        else
        begin
            state<=3;col<=4'b1011;
        end
    end
    3:
    begin
        if(inrow!=4'b1111)
        begin
            state<=5;
        end     
        else
        begin
            state<=4;col<=4'b0111;
        end
    end
    4:  
    begin
        if(inrow!=4'b1111)
        begin
            state<=5;
        end
        else state<=0;
    end
    5:
    begin
        if(inrow!=4'b1111)
        begin
            inrow_reg<=inrow;    
            outcol_reg<=col;    
            key_flag<=1'b1;      
            state<=5;            
        end
        else    state<=0;
    end
endcase
end 

always@(clock)
begin
		if (keynum_1 == {outcol_reg,inrow_reg}) 
        begin 
			jud_flag<=1;
        end
        else 
        begin
			jud_flag<=0;
			keynum_1<={outcol_reg,inrow_reg};
        end
 
end

always@(posedge clock)
begin
    if(key_flag==1'b1)
    begin
			
			    
			case({outcol_reg,inrow_reg})
            8'b1110_1110:begin  key_value<=0;lemp_0<=~lemp_0;end 
            8'b1110_1101:begin  key_value<=1;lemp_1<=~lemp_1;end 
            8'b1110_1011:begin  key_value<=2;lemp_2<=~lemp_2;end 
            8'b1110_0111:begin  key_value<=3;lemp_3<=~lemp_3;end 
            8'b1101_1110:begin  key_value<=4;lemp_4<=~lemp_4;end 
            8'b1101_1101:begin  key_value<=5;lemp_5<=~lemp_5;end 
            8'b1101_1011:begin  key_value<=6;lemp_6<=~lemp_6;end 
            8'b1101_0111:begin  key_value<=7;lemp_7<=~lemp_7;end 
            8'b1011_1110:begin  key_value<=8;lemp_8<=~lemp_8;end 
            8'b1011_1101:begin  key_value<=9;lemp_9<=~lemp_9;end 
            8'b1011_1011:begin key_value<=10;end
            8'b1011_0111:begin key_value<=11;end
            8'b0111_1110:begin key_value<=12;end
            8'b0111_1101:begin key_value<=13;end
            8'b0111_1011:begin key_value<=14;end
            8'b0111_0111:begin key_value<=16;end
            default: key_value <= 16; 
			endcase
    end
end

assign key_ready=key_flag;
assign outcol=col;

endmodule