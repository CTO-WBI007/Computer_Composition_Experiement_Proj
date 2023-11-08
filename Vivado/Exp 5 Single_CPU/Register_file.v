module Register_file(
    input [4:0]rs,
    input [4:0]rt,
    input [4:0]rd,
    input [31:0]data,
    input reset,
    input CLK,
    input write_able,
    output[31:0]out_data1,
    output[31:0]out_data2
    );
    reg[31:0] memory[31:0];

    integer i;
    initial begin
        for(i=0;i<32;i=i+1)memory[i]<=0;
    end
    
    always@(posedge CLK)begin
        if(reset)begin
        end
        else if(write_able==1)
            memory[rd]=data;
    end
    assign out_data1=memory[rs];
    assign out_data2=memory[rt];
    
endmodule
