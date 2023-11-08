module CPU_control(
    input [5:0]opcode,
    input [5:0]alu_function,
    input CLK,
    output reg reset,
    output reg complete,
    output reg regdst,
    output reg Alu_src,
    output reg [2:0]Aluop,
    output reg MemtoReg,
    output reg Regwrite,
    output reg Memread,
    output reg jump,
    output reg Memwrite,
    output reg branch
    );
    
    initial begin
        complete=1'b0;
        reset=1'b1;
    end

    
    
    
    always@(*)begin
        if(opcode==6'b000000)begin
            regdst=1'b0;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b0;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b1;//ts
            Memwrite=1'b0;//ts
            Memread=1'b0;
            jump=1'b0;
            //complete=1'b0;
            branch=1'b0;
            reset=1'b0;
            if(alu_function==6'b100000)
                Aluop=3'b000;
            else if(alu_function==6'b100001)
                Aluop=3'b000;
            else if(alu_function==6'b000000)
                Aluop=3'b101;
            else if(alu_function==6'b101010)
                Aluop=3'b100;
            else if(alu_function==6'b000000)begin
                Regwrite=1'b0;
                Aluop=3'b000;
            end
        end
        else if(opcode==6'b001000)begin
            regdst=1'b1;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b1;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b1;//ts
            Memwrite=1'b0;//ts
            Memread=1'b0;
            jump=1'b0;
            //complete=1'b0;
            branch=1'b0;
            Aluop=3'b000;
            reset=1'b0;
        end
        else if(opcode==6'b001001)begin
            regdst=1'b1;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b1;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b1;//ts
            Memwrite=1'b0;//ts
            Memread=1'b0;
            //complete=1'b0;
            jump=1'b0;
            branch=1'b0;
            Aluop=3'b000;
             reset=1'b0;
        end
        else if(opcode==6'b001111)begin
            regdst=1'b0;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b1;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b1;//ts
            Memwrite=1'b0;//ts
            Memread=1'b0;
            jump=1'b0;
            //complete=1'b0;
            branch=1'b0;
            Aluop=3'b000;  
             reset=1'b0;     
        end
        else if(opcode==6'b001101)begin
            regdst=1'b1;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b1;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b1;//ts
            Memwrite=1'b0;//ts
            Memread=1'b0;
            jump=1'b0;
            branch=1'b0;
            //complete=1'b0;
            Aluop=3'b011;
             reset=1'b0;
        end
        else if(opcode==6'b000100)begin
            regdst=1'b1;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b0;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b0;//ts
            Memwrite=1'b0;//ts
            Memread=1'b0;
            jump=1'b0;
            branch=1'b1;
            Aluop=3'b001;
            //complete=1'b0;
             reset=1'b0;
        end
        else if(opcode==6'b101011)begin
            regdst=1'b1;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b1;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b0;//ts
            Memwrite=1'b1;//ts
            Memread=1'b0;
            jump=1'b0;
            branch=1'b0;
           // complete=1'b0;
            Aluop=3'b000;
             reset=1'b0;
        end
        else if(opcode==6'b100011)begin
            regdst=1'b1;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b1;//同上；
            MemtoReg=1'b1;//ts;
            Regwrite=1'b1;//ts
            Memwrite=1'b0;//ts
            Memread=1'b1;
            //complete=1'b0;
            jump=1'b0;
            branch=1'b0;
            Aluop=3'b000;
             reset=1'b0;
        end
        else if(opcode==6'b000010)begin
            regdst=1'b1;//根据笔者所编写的表中，所实现的13条指令中，R型指令的regdst都为0；
            Alu_src=1'b0;//同上；
            MemtoReg=1'b0;//ts;
            Regwrite=1'b0;//ts
            Memwrite=1'b0;//ts
            Memread=1'b0;
            jump=1'b1;
            //complete=1'b0;
            branch=1'b0;
            Aluop=3'b000;
             reset=1'b0;
        end
        else if(opcode==6'b111111)begin
            if(alu_function==6'b110000)begin
                reset=1'b1;
                //complete=1'b1;
            end
            else begin
                complete=1'b1;
                reset=1'b1;
            end
        end
    end
