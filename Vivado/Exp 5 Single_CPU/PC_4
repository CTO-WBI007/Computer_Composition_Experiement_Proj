module PC_4(
    input [31:0]address,
    input CLK,
    input reset,
    output reg[31:0]nextPC
    );
    
    
    
    always@(*)begin
        if(reset)begin
            nextPC=32'h00000000;
        end
        else
            nextPC=address+4;
    end
endmodule
