module newshumaguan
(
    CLK,
    segData,segCtl,segData_1,segData_2,segData_3,segData_4
);

input CLK;
output reg [7:0]segData;
output reg [3:0]segCtl;
input [3:0]segData_1;
input [3:0]segData_2;
input [3:0]segData_3;
input [3:0]segData_4;

reg [7:0]segDataReg;                           
reg [3:0]segCtlReg;                            
reg [1:0]segState;                             

reg [15:0]cnt1ms;
reg clk1000Hz;
always@(posedge CLK)                        
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
        case(segState)                          
        2'b00:
            begin
            segCtlReg<=4'b0001;
            segState<=segState+2'b01;           
            segDataReg<=segData_1;              
            end
        2'b01:
            begin
            segCtlReg<=4'b0010;
            segState<=segState+2'b01;
            segDataReg<=segData_2;
            end
        2'b10:
            begin
            segCtlReg<=4'b0100;
            segState<=segState+2'b01;
            segDataReg<=segData_3;
            end
        2'b11:
            begin
            segCtlReg<=4'b1000;
            segDataReg<=segData_4;
            segState<=2'b00;
            end
        default:;
        endcase
    end

always@(posedge CLK)                    
    begin
    segCtl<=segCtlReg;                      
    case(segDataReg)
        4'd12:
            segData<=8'b1111_1111;          
        4'd11:
            segData<=8'b1100_0110;         
        4'd10:
            segData<=8'b0111_1111;          
        4'd9:
            segData<=8'b1001_0000;
        4'd8:
            segData<=8'b1000_0000;
        4'd7:
            segData<=8'b1111_1000;
        4'd6:
            segData<=8'b1000_0010;
        4'd5:
            segData<=8'b1001_0010;
        4'd4:
            segData<=8'b1001_1001;
        4'd3:
            segData<=8'b1011_0000;
        4'd2:
            segData<=8'b1010_0100;
        4'd1:
            segData<=8'b1111_1001;
        4'd0:
            segData<=8'b1100_0000;
        default:;
        endcase
    end
endmodule	
