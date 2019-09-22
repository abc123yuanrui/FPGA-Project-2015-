module keylogic( //������ʾ������ģ��
        input wire clk, //ʱ��25/cnt[16]
        input wire [4:0] keycode, //��������
        input key_ready,
        input change_lemp,//����״̬
        input change_lemp1,//�жϸ���״̬
        input flag_b ,//�����Ƿ�ɹ�״̬
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
        always@ (posedge clk) //��ֵ����
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