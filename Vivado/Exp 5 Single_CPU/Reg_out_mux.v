module reg_out_mux(
    input [31:0]data2,
    input [31:0]imm,
    input Alusrc,
    input CLK,
    output reg [31:0]realdata
    );
    
    always@(*)begin
        if(Alusrc)begin
            realdata=imm;
        end
        else realdata=data2;
    end
endmodule
