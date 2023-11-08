module address_mux(
    input CLK,
    input [31:0]imm,
    input jump,
    input zero,
    input branch,
    input [31:0]address,
    output reg[31:0]final_address
    );
    
    always@(*)begin
        if(jump)begin
            final_address={imm[29:0],2'b00};
            final_address={address[31:28],final_address[27:0]};
        end
        else if(branch==1&&zero==1)begin
            final_address={imm[29:0],2'b00};
            final_address=final_address+address;
        end
        else begin
            final_address=address;
        end
    end
endmodule
