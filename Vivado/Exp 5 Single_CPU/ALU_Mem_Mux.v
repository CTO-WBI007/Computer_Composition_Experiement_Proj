module Alu_Mem_mux(
    input MemtoReg,
    input [31:0]data1,
    input [31:0]data2,
    input CLK,
    output reg [31:0]data
    );
    always@(*)begin
        if(MemtoReg==1)
            data=data1;
        else
            data=data2;
    end
endmodule
