module keylogic( //按键显示处理子模块
        input wire clk, //时钟25/cnt[16]
        input wire [4:0] keycode, //按键编码
        input key_ready,
        input change_lemp,//改密状态
        input change_lemp1,//判断改密状态
        input flag_b ,//开锁是否成功状态
        output  [3:0]segData_1,
		output  [3:0]segData_2,
		output  [3:0]segData_3,
		output  [3:0]segData_4
        );
        reg [3:0]segData_r1;
		reg [3:0]segData_r2;
		reg [3:0]segData_r3;
		reg [3:0]segData_r4;
        reg [15:0] lednum;
        reg keypressdone = 1'b1; 
        reg [4:0] keycode1 = 5'h10; 
        always @ (negedge  key_ready ) 
        begin
            if(keycode<10)
            begin
				if(flag_b==0)
				begin
                  lednum = lednum << 4; 
                  lednum[3:0] = 10;     
				end 
				else if(flag_b==1&&change_lemp1==0)
				begin
				  lednum = lednum << 4; 
                  lednum[3:0] = keycode[3:0];    
				end
				else if(flag_b==1&&change_lemp==0)
				begin
				  lednum = lednum << 4; 
				  lednum[3:0] = 11;   
			    end
			 end
       end
        always@ (posedge clk) //键值传递
		begin
		   segData_r1<=lednum[3:0];
           segData_r2<=lednum[7:4];
           segData_r3<=lednum[11:8];
           segData_r4<=lednum[15:12];
		end
        
         assign segData_1[3:0]=segData_r1;
         assign segData_2[3:0]=segData_r2;
         assign segData_3[3:0]=segData_r3;
         assign segData_4[3:0]=segData_r4;
 
endmodule