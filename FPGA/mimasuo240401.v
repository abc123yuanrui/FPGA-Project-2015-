module mimasuo240401 ( //顶层模块
        input clk, 
        input rst, 
        input   [3:0]   inrow,                
		output  [3:0]   outcol,                
        output  [7:0] segData,
		output  [3:0] segCtl,
        output  lemp_0,
		output  lemp_1,
		output  lemp_2,
		output  lemp_3,
		output  lemp_4,
		output  lemp_5,
		output  lemp_6,
		output  lemp_7,
		output  lemp_8,
		output  lemp_9,
		output  led_1,
		output  led_2,
		output  led_3,
		output change_lemp,
		output change_lemp1,
		output  flag_b,					
		output bee//蜂鸣器，高电平响，低电平停
				     );

           wire[3:0] segData_1;
           wire[3:0] segData_2;
           wire[3:0] segData_3;
           wire[3:0] segData_4;
           //wire[3:0] flag;
           wire [4:0]   key_value;  
           wire [4:0]   keycode; 
           wire [2:0] flag_time;
           
        reg [18:0] cnt = 19'd0; //19位记数器，用于时序控制
        always @ (posedge clk)         cnt = cnt + 1'b1; 
       keylogic u2( .clk(cnt[16]),
					.keycode(key_value),
					.key_ready(key_ready),
					.segData_1(segData_1),.segData_2(segData_2),.segData_3(segData_3),.segData_4(segData_4),
					.change_lemp(change_lemp),.change_lemp1(change_lemp1),
					.flag_b (flag_b)
				); 
       jianpan u1(.lemp(lemp),.lemp_0(lemp_0),.lemp_1(lemp_1),.lemp_2(lemp_2),.lemp_3(lemp_3),.lemp_4(lemp_4),.lemp_5(lemp_5),.lemp_6(lemp_6),.lemp_7(lemp_7),.lemp_8(lemp_8),.lemp_9(lemp_9),
					.clk(cnt[0]),.inrow(inrow),.outcol(outcol),
					.key_value(key_value),
					.key_ready(key_ready)
					);
		
       newshumaguan u3( .CLK(clk),
						.segCtl(segCtl),.segData(segData),
						.segData_1(segData_1),.segData_2(segData_2),.segData_3(segData_3),.segData_4(segData_4)
						
					  );

	   password u4(
                    .keycode(key_value) ,
                    .clk(clk),
                    .change_lemp(change_lemp),
                    .change_lemp1(change_lemp1),
					.flag_b (flag_b),//输出判断开锁还是改密两种状态
			        . flag_time(flag_time),//输错密码次数
			        .k1(k1),
			       
			        .led_1(led_1),.led_2(led_2),.led_3(led_3),
			        .key_ready(key_ready)
                   );
    
       bee u5(
					.keycode(key_value) ,
					.key_ready(key_ready),
					.clk(clk),
					.flag_time(flag_time),
					.bee (bee),
					.flag_b (flag_b),
					
					.k1(k1)
             );
endmodule
