module reg_mux(
    input regdst,
    input [4:0]rt,
    input CLK,
    input [4:0]rd,
    output reg [4:0]nrd
    );
    
    
    always@(*)begin
        if(regdst)
            nrd=rt;
        else
            nrd=rd;
    end
endmodule
