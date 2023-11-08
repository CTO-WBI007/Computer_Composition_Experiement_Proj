module Sign_extend1(
    input [15:0] shortimm,
    input [25:0] initial_jump_address,
    input CLK,
    input jump,
    output reg [31:0]imm
    );
    
    
    always@(*)begin
        if(jump)
            imm={{6{initial_jump_address[25]}},initial_jump_address[25:0]};
        else
            imm={{16{shortimm[15]}},shortimm[15:0]};
    end
endmodule
