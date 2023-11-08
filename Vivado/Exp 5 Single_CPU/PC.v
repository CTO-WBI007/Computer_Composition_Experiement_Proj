module PC(
    input [31:0]new_address,
    input CLK,
    input reset,
    output reg [31:0]out_address
    );
    initial begin
        out_address=32'h00000000; 
    end
    always@(posedge CLK)begin
        if(reset==1'b1)begin
            out_address = 32'h00000000;
        end
        else
            out_address = new_address;
    end
endmodule
