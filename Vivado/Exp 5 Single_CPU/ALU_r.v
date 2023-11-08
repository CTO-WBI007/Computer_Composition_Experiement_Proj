module ALU_r(
    input [31:0]data1,
    input [31:0]data2,
    input [4:0]shamt,
    input CLK,
    input reset,
    input [2:0]Aluop,
    output reg [31:0]alu_output,
    output reg zero
    );
    
    always@(*)begin
        if(reset)begin
                alu_output=32'h00000000;
                zero=0;
        end
        else begin
            case(Aluop)
                3'b000:begin alu_output=data1+data2;end
                3'b001:begin alu_output=data1-data2;end
                3'b010:begin alu_output=data1&data2;end
                3'b011:begin alu_output=data1|data2;end
                3'b100:begin alu_output=(data1<data2)? 32'h00000001:32'h00000000;end
                3'b101:begin alu_output=data2<<shamt;end
                default:alu_output=data1+data2;
            endcase
            if(data1==data2)zero=1;
            else zero=0;
        end
    end
endmodule
