//------------------------------------------
//      完成八段数码管的显示功能.
//------------------------------------------
 module xianshiluoji( 
        input wire clk, 
        input wire [4:0] keycode, 
        input key_ready,
        input change_lemp,
        input change_lemp1,
        input flag_b ,
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
        reg [1:0] flagc;
        reg keypressdone = 1'b1; 
        reg [4:0] keycode1 = 5'h10; 
        initial begin flagc=0;
         end
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
				  case(flagc)
						2'b00:begin lednum[3:0]<=keycode;lednum[15:12]<=13;lednum[11:8]<=13;lednum[7:4]<=13;flagc<=flagc+1;end
						2'b01:begin lednum[7:4]<=keycode;flagc<=flagc+1;end
						2'b10:begin lednum[11:8]<=keycode;flagc<=flagc+1;end
						2'b11:begin lednum[15:12]<=keycode;
									flagc<=0;
								end
					endcase   
				end
				else if(flag_b==1&&change_lemp==0)
				begin
				  lednum = lednum << 4; 
				  lednum[3:0] = 11;   
			    end
			 end
       end
        always@ (posedge clk) 
		begin
		   segData_r1<=lednum[3:0];
           segData_r2<=lednum[7:4];
           segData_r3<=lednum[11:8];
           segData_r4<=lednum[15:12];//tong xia
		end
        
         assign segData_1[3:0]=segData_r1;
         assign segData_2[3:0]=segData_r2;
         assign segData_3[3:0]=segData_r3;
         assign segData_4[3:0]=segData_r4;//from left to right xianshi shuzi 
endmodule