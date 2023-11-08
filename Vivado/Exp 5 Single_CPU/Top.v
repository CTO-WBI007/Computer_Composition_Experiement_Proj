module Top(
    input CLK_in,
    input button_up,
    input button_down,
    input button_left,
    input button_right,
    input button_middle,
    input[15:0]data,
    output [9:0]position,
    output show,
    output complete,
    output [3:0]seg,
    output [6:0]a_to_g
    );
    wire CLK;
    wire[31:0] IMEM_output_instruction;
    wire[31:0] PC_out_address;
    wire regdst;
    wire Alusrc;
    wire[2:0]Aluop;
    wire MemtoReg;
    wire Regwrite;
    wire Memwrite;
    wire Memread;
    wire jump;
    wire zero;
    wire branch;
    wire [31:0]nextPC;
    wire[4:0] nrd;
    wire[31:0]reg_outdata1;
    wire[31:0]reg_outdata2;
    wire[31:0]imm;
    wire[31:0]realdata;
    wire[31:0]alu_output;
    wire[31:0]data_mem_outdata;
    wire[31:0]write_data;
   // wire[31:0]showdata;
    wire[31:0]final_address;
    wire[31:0]read_data;
    wire[31:0]i;
    wire reset;
    wire temp;////111
    assign read_data={16'h0000,data[15:0]};



    reg[3:0]addr;
    reg [3:0]addrr;
    reg[3:0]addrl;
    initial addr <= 0;
    parameter MAX = 20'd1_000_000;
    reg [19:0]cnt_delay;
    reg key_00;
    reg key_01;
    reg flag;
    wire nedge;
    wire add_cnt;
    wire end_cnt;

    initial flag = 1;
    initial cnt_delay = 20'b0;
    always@(posedge CLK_in)
    begin
        key_00 <= button_right;
    end
    always@(posedge CLK_in)
    begin
        key_01 <= key_00;
    end
    
    assign nedge = key_00 & ~key_01;
    always@(posedge CLK_in)
    begin    
        if(end_cnt)    flag <= 1'b0;
        else if(nedge)    flag <= 1'b1;
    end
  
    always@(posedge CLK_in)
        begin
            if(add_cnt)
            begin
               if(end_cnt)
               cnt_delay <= 20'b0;
               else
               cnt_delay <= cnt_delay + 1;
            end
        end 
    assign add_cnt = flag;
    assign end_cnt = add_cnt && cnt_delay == MAX-1;
    always@(posedge CLK_in)
    begin
        addrr=addr;
        if(end_cnt)
        begin
        if(button_right) begin
            if(addrr < 9) addrr <= addrr+1;
            else    addrr <= 0;
            end   
        end
    end
    
    
    
    
    
    
    

        parameter MAX1 = 20'd1_000_000;
        reg [19:0]cnt_delay1;
        reg key_001;
        reg key_011;
        reg flag1;
        wire nedge1;
        wire add_cnt1;
        wire end_cnt1;
    
        initial flag1 = 1;
        initial cnt_delay1 = 20'b0;
        always@(posedge CLK_in)
    begin
        key_001 <= button_left;
    end
    always@(posedge CLK_in)
    begin
        key_011 <= key_001;
    end
    
    assign nedge1 = key_001 & ~key_011;
    always@(posedge CLK_in)
    begin    
        if(end_cnt1)    flag1 <= 1'b0;
        else if(nedge1)    flag1 <= 1'b1;
    end
  
    always@(posedge CLK_in)
        begin
            if(add_cnt1)
            begin
               if(end_cnt1)
               cnt_delay1 <= 20'b0;
               else
               cnt_delay1 <= cnt_delay1 + 1;
            end
        end 
    assign add_cnt1 = flag1;
    assign end_cnt1 = add_cnt1 && cnt_delay1 == MAX1-1;
    always@(posedge CLK_in)
    begin
        addrl=addr;
        if(end_cnt1)
        begin
        if(button_left) begin
            if(addrl > 0) addrl <= addrl-1;
            else   addrl <= 9;
            end   
        end
    end
    
    always@(*)begin
        if(button_right)addr=addrr;
        else if(button_left)addr=addrl;
    end
    

    
    assign i={24'h000000,2'b00,addr[3:0],2'b00};

    clk_div clk_div1(
        .CLK_in(CLK_in),
        .CLK_out(CLK)
    );
    PC PC1(
        .CLK(CLK),
        .reset(reset),
        .new_address(final_address),
        .out_address(PC_out_address)
    );
    PC_4 PC_41(
        .CLK(CLK),
        .reset(reset),
        .address(PC_out_address),
        .nextPC(nextPC)
    );
    address_mux address_mux(
        .CLK(CLK),
        .imm(imm),
        .jump(jump),
        .zero(zero),
        .branch(branch),
        .address(nextPC),
        .final_address(final_address)
    );
    IMEM IMEM1(
        .CLK(CLK),
        .reset(reset),
        .start(button_middle),
        .address(PC_out_address),
        .temp(temp),
        .output_instruction(IMEM_output_instruction)
    );
    CPU_control CPU_control1(
        .CLK(CLK),
        .opcode(IMEM_output_instruction[31:26]),
        .alu_function(IMEM_output_instruction[5:0]),
        .regdst(regdst),
        .Alu_src(Alusrc),
        .Aluop(Aluop),
        .complete(complete),
        .MemtoReg(MemtoReg),
        .Regwrite(Regwrite),
        .reset(reset),
        .Memwrite(Memwrite),
        .jump(jump),
        .branch(branch),
        .Memread(Memread)
    );
    Sign_extend1 Sign_extend11(
        .CLK(CLK),
        .shortimm(IMEM_output_instruction[15:0]),
        .initial_jump_address(IMEM_output_instruction[25:0]),
        .imm(imm),
        .jump(jump)
    );
    reg_mux reg_mux1(
        .CLK(CLK),
        .regdst(regdst),
        .rt(IMEM_output_instruction[20:16]),
        .rd(IMEM_output_instruction[15:11]),
        .nrd(nrd)
    );
    Register_file Register_file1(
        .CLK(CLK),
        .rs(IMEM_output_instruction[25:21]),
        .rt(IMEM_output_instruction[20:16]),
        .rd(nrd),
        .reset(reset),
        .data(write_data),
        .write_able(Regwrite),
        .out_data1(reg_outdata1),
        .out_data2(reg_outdata2)
    );
    
    reg_out_mux reg_out_mux1(
        .CLK(CLK),
        .data2(reg_outdata2),
        .imm(imm),
        .Alusrc(Alusrc),
        .realdata(realdata)
    );
    ALU_r ALU_r1(
        .reset(reset),
        .data1(reg_outdata1),
        .data2(realdata),
        .shamt(IMEM_output_instruction[10:6]),
        .CLK(CLK),
        .Aluop(Aluop),
        .zero(zero),
        .alu_output(alu_output)
    );
    Data_Mem Data_Mem1(
        .CLK(CLK),
        .reset(reset),
        .s_data(read_data),
        .button_up(button_up),
        .button_right(button_right),
        .button_left(button_left),
        .start(button_middle),
        .write_data(reg_outdata2),
        .MemWrite(Memwrite),
        .MemRead(Memread),
        .addr(alu_output),
        .i(i),
        .button_down(button_down),
        .outdata(data_mem_outdata)
    );
    Alu_Mem_mux Alu_Mem_mux1(
        .CLK(CLK),
        .data1(data_mem_outdata),
        .data2(alu_output),
        .MemtoReg(MemtoReg),
        .data(write_data)
    );
    display display1(
        .CLK(CLK),
        .outdata(data_mem_outdata[15:0]),
        .s_data(data),
        .button_up(button_up),
        .i(addr),
        .position(position),
        .seg(seg),
        .a_to_g(a_to_g),
        .show(show)
    );
    

endmodule
