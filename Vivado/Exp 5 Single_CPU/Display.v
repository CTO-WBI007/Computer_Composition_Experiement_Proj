module display(
    input CLK,
    input [15:0]outdata,
    input [15:0]s_data,
    input button_up,
    input [3:0]i,
    output reg [9:0]position,
    output reg [3:0]seg,
    output reg [6:0]a_to_g,
    output reg show
    );
    reg [3:0] temp;
    reg [7:0] x;
    wire [15:0]Data;
    assign Data=(button_up==1)?outdata:s_data;
//   initial begin
//        temp=0;
//    end
    //位选
    
    
   always@(*)begin
        case(i)
            0:begin position=10'b1000000000;end
            1:begin position=10'b0100000000;end
            2:begin position=10'b0010000000;end
            3:begin position=10'b0001000000;end
            4:begin position=10'b0000100000;end
            5:begin position=10'b0000010000;end
            6:begin position=10'b0000001000;end
            7:begin position=10'b0000000100;end
            8:begin position=10'b0000000010;end
            9:begin position=10'b0000000001;end
            default begin position=10'b0000000001;end
        endcase
    end
    always@(posedge CLK)begin
        if(button_up==1)begin
            show=1'b1;
        end
        else begin
            show=1'b0;
        end
        //tempi=i;
        //显示结果还是显示操作数
            case (temp)
                0: begin x = Data/4096; seg=4'b0111;end//低电平有效，选中第一位
                1: begin x = Data/256%16; seg=4'b1011;end//低电平有效，选中第二位
                2: begin x = Data/16%16; seg=4'b1101;end//低电平有效，选中第三位
                3: begin x = Data%16; seg=4'b1110;end//低电平有效，选中第四位
            endcase
         temp=temp+1;
         if(temp==4)
            temp=0;
    end
    
    
    //duanxuan
    always@(*)begin
        case(x)
            0:a_to_g =7'b0000001;
            1:a_to_g =7'b1001111;
            2:a_to_g =7'b0010010;
            3:a_to_g =7'b0000110;
            4:a_to_g =7'b1001100;
            5:a_to_g =7'b0100100;
            6:a_to_g =7'b0100000;
            7:a_to_g =7'b0001111;
            8:a_to_g =7'b0000000;
            9:a_to_g =7'b0000100;
            'hA:a_to_g =7'b0001000;
            'hB:a_to_g =7'b1100000;
            'hC:a_to_g =7'b0110001;
            'hD:a_to_g =7'b1000010;
            'hE:a_to_g =7'b0110000;
            'hF:a_to_g =7'b0111000;
            default:a_to_g =7'b0000001;
        endcase
    end

    
endmodule
