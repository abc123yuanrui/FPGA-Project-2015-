//----------------------------------------
//      得出矩阵键盘输入的键值。
//----------------------------------------
module jianpandujianma(
					clk,
					inrow,outcol,
					key_value,
					key_ready,
					
						);

input   clk;                            
input   [3:0]   inrow;                 
output  [3:0]   outcol;          //outcode    
output  [4:0]   key_value;           // code  
output  key_ready;                      
reg     clock;                          
reg     clock_2;                          
reg     clock_3;  
reg     key_flag;                       
reg     jud_flag;                       
reg     [3:0]   col;                    
reg     [3:0]   inrow_reg;    //shuzhe           
reg     [3:0]   outcol_reg;      //hang        
reg     [2:0]   state;                  
reg     [4:0]   key_value;             
reg     [15:0]  count;
reg     [15:0]  count_2;
reg     [15:0]  count_3;
reg     [30:0]  count_4;
reg     [7:0]   keynum_1;              
reg     [7:0]   key_num0;              
//产生25hz时钟
always@(posedge clk)                    
begin
    count<=count+1;
    if(count>=15'd500000)                          
    begin
        clock<=~clock;
        count<=0;                         
    end
end
////////////////////////////////////////////
//通过6状态状态机完成对键盘的扫描：总确定是否有按键—>逐行扫描—>统一处理
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
/////////////////////////////////////////////////////////
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
//对键盘扫描结果译码得到按键数值
always@(posedge clock)
begin
    if(key_flag==1'b1)
    begin
			
			    
			case({outcol_reg,inrow_reg})// hang shuzhe
            8'b1110_1110:begin  key_value<=0;end 
            8'b1110_1101:begin  key_value<=1;end 
            8'b1110_1011:begin  key_value<=2;end 
            8'b1110_0111:begin  key_value<=3;end 
            8'b1101_1110:begin  key_value<=4;end 
            8'b1101_1101:begin  key_value<=5;end 
            8'b1101_1011:begin  key_value<=6;end 
            8'b1101_0111:begin  key_value<=7;end 
            8'b1011_1110:begin  key_value<=8;end 
            8'b1011_1101:begin  key_value<=9;end 
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

assign key_ready=key_flag;// cmd is key_ready
assign outcol=col;

endmodule