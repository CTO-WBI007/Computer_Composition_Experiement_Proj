module IMEM(
    input [31:0] address,	// 指令的地址
	input CLK, 
	input start,
	input reset,
	output reg temp,//111
    output reg [31:0] output_instruction	// 指令
);

	reg [7:0] data [255:0];	// 32*256大小的指令存储缓冲器
	initial begin
	
	   $readmemh("D:\\Vivado Trial\\CPU_NEW\\CPU_NEW.sim\\text1.txt", data);
	end
	//reg temp;
	always@(*)begin
	   if(start==1)begin
	       temp=0;
	   end
	   else begin
	       temp=reset;
	   end
	   if(temp)begin
	       output_instruction=32'hfffffff0;
	   end
	   else begin
           output_instruction[31:24]=data[address];
           output_instruction[23:16]=data[address+1];
           output_instruction[15:8]=data[address+2];
           output_instruction[7:0]=data[address+3];
	   end
	end

endmodule
