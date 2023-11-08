module Data_Mem(
    input CLK,
    input[31:0] write_data,
    input[31:0] s_data,
    input MemWrite,
    input reset,
    input MemRead,
    input button_down,
    input button_right,
    input button_left,
    input button_up,
    input start,
    input [31:0]addr,
    input [31:0] i,
    output reg [31:0]outdata
    );
    
    reg [7:0] ram[255:0];
    wire [31:0]temp;
    //reg test;
    integer j;
    initial begin
        for(j=0;j<256;j=j+1)ram[j]<=0;
    end

        always@(*)begin
            if(button_up==1)begin
                outdata[31:24]=ram[i];
                outdata[23:16]=ram[i+1];
                outdata[15:8]=ram[i+2];
                outdata[7:0]=ram[i+3];
            end
            else if(MemRead==1&&reset==0)begin
                outdata[31:24]=ram[addr];
                outdata[23:16]=ram[addr+1];
                outdata[15:8]=ram[addr+2];
                outdata[7:0]=ram[addr+3];
            end
            else begin
            end
        end
        always@(posedge CLK)begin
            if(button_down==1)begin
                ram[i]<=s_data[31:24];
                ram[i+1]<=s_data[23:16];
                ram[i+2]<=s_data[15:8];
                ram[i+3]<=s_data[7:0];
            end
            else if(MemWrite==1&&reset==0)begin
                 ram[addr] <=write_data[31:24];
                 ram[addr+1] <=write_data[23:16];
                 ram[addr+2] <=write_data[15:8];
                 ram[addr+3] <=write_data[7:0];
            end
        end
    

       
endmodule
