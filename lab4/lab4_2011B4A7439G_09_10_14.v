
// ****************** D FF ***************************************

module D_ff_Mem(input clk, input reset, input init, input writeEn, input d, output reg q);
	always@(negedge clk)
	begin
		if(reset)			q=init;
		else
			if(writeEn==1)	q=d;
	end
endmodule


// ****************** 8 bit MEMORY ***************************************

module Mem8bit(input clk, input reset, input [7:0] init, input writeEn, input [7:0] writeData, output [7:0] outR);
	D_ff_Mem D0(clk, reset, init[0], writeEn, writeData[0], outR[0]);
	D_ff_Mem D1(clk, reset, init[1], writeEn, writeData[1], outR[1]);
	D_ff_Mem D2(clk, reset, init[2], writeEn, writeData[2], outR[2]);
	D_ff_Mem D3(clk, reset, init[3], writeEn, writeData[3], outR[3]);
	D_ff_Mem D4(clk, reset, init[4], writeEn, writeData[4], outR[4]);
	D_ff_Mem D5(clk, reset, init[5], writeEn, writeData[5], outR[5]);
	D_ff_Mem D6(clk, reset, init[6], writeEn, writeData[6], outR[6]);
	D_ff_Mem D7(clk, reset, init[7], writeEn, writeData[7], outR[7]);
endmodule


// ****************** MEMORY BLOCK ***************************************

module MemBlock(input clk, input reset, input [15:0] init0, init1, init2, init3, init4, init5, init6, init7, input MemWrite, input [7:0] decOut, input [15:0] writeData, output [7:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,outR8,outR9,outR10,outR11,outR12,outR13,outR14,outR15);
	Mem8bit m00(clk, reset, init0[7:0],  MemWrite&decOut[0], writeData[7:0],  outR0);
	Mem8bit m01(clk, reset, init0[15:8], MemWrite&decOut[0], writeData[15:8], outR1);
	Mem8bit m02(clk, reset, init1[7:0],  MemWrite&decOut[1], writeData[7:0],  outR2);
	Mem8bit m03(clk, reset, init1[15:8], MemWrite&decOut[1], writeData[15:8], outR3);	
	Mem8bit m04(clk, reset, init2[7:0],  MemWrite&decOut[2], writeData[7:0],  outR4);
	Mem8bit m05(clk, reset, init2[15:8], MemWrite&decOut[2], writeData[15:8], outR5);
	Mem8bit m06(clk, reset, init3[7:0],  MemWrite&decOut[3], writeData[7:0],  outR6);
	Mem8bit m07(clk, reset, init3[15:8], MemWrite&decOut[3], writeData[15:8], outR7);	
	Mem8bit m08(clk, reset, init4[7:0],  MemWrite&decOut[4], writeData[7:0],  outR8);
	Mem8bit m09(clk, reset, init4[15:8], MemWrite&decOut[4], writeData[15:8], outR9);
	Mem8bit m10(clk, reset, init5[7:0],  MemWrite&decOut[5], writeData[7:0],  outR10);
	Mem8bit m11(clk, reset, init5[15:8], MemWrite&decOut[5], writeData[15:8], outR11);	
	Mem8bit m12(clk, reset, init6[7:0],  MemWrite&decOut[6], writeData[7:0],  outR12);
	Mem8bit m13(clk, reset, init6[15:8], MemWrite&decOut[6], writeData[15:8], outR13);
	Mem8bit m14(clk, reset, init7[7:0],  MemWrite&decOut[7], writeData[7:0],  outR14);
	Mem8bit m15(clk, reset, init7[15:8], MemWrite&decOut[7], writeData[15:8], outR15);
endmodule


// ****************** MEMORY 3:8 DECODER ***************************************

module MemDec3to8(input [2:0] MemDest, output reg [7:0] MemDecOut);	 
	 always@(MemDest)
	 	case(MemDest)
			3'b000: MemDecOut=8'b00000001;
			3'b001: MemDecOut=8'b00000010;
			3'b010: MemDecOut=8'b00000100;
			3'b011: MemDecOut=8'b00001000;
			3'b100: MemDecOut=8'b00010000;
			3'b101: MemDecOut=8'b00100000;
			3'b110: MemDecOut=8'b01000000;
			3'b111: MemDecOut=8'b10000000;
		endcase
endmodule
 


// ****************** 8:1 MUX *************************************** 

module MemMux8to1(input [7:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7, input [2:0] Sel, output reg [7:0] outBus);	
	always@(outR0 or outR1 or outR2 or outR3 or outR4 or outR5 or outR6 or outR7 or Sel)
		case (Sel)
			3'b000: outBus=outR0;
			3'b001: outBus=outR1;
			3'b010: outBus=outR2;
			3'b011: outBus=outR3;
			3'b100: outBus=outR4;
			3'b101: outBus=outR5;
			3'b110: outBus=outR6;
			3'b111: outBus=outR7;
		endcase
endmodule 


// ****************** 2:1 8 bit MUX ***************************************

module MemMux2to1(input [7:0] outBus, input [7:0] zero, input MemRead, output reg [7:0] MemOut);	
	always@(outBus or zero or MemRead)
		case (MemRead)
			1'b0: MemOut=outBus;
			1'b1: MemOut=zero;
		endcase	
endmodule


// ****************** MEMORY ***************************************

module Memory(input clk, input reset, input [15:0] init0, init1, init2, init3, init4, init5, init6, init7, input MemWrite, input MemRead, input [15:0] Addr, input [15:0] writeData, output [7:0] MemBus0, output [7:0] MemBus1);
	wire [7:0] MemDecOut, outBus0, outBus1;
	wire [7:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,outR8,outR9,outR10,outR11,outR12,outR13,outR14,outR15;
	
	MemDec3to8 MD0(Addr[3:1], MemDecOut);		
	MemBlock MB0(clk, reset, init0, init1, init2, init3, init4, init5, init6, init7, MemWrite, MemDecOut,writeData, outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,outR8,outR9,outR10,outR11,outR12,outR13,outR14,outR15);	
	MemMux8to1 MM8_0(outR0,outR2,outR4,outR6,outR8,outR10,outR12,outR14,Addr[3:1], outBus0);
	MemMux8to1 MM8_1(outR1,outR3,outR5,outR7,outR9,outR11,outR13,outR15,Addr[3:1], outBus1);
	MemMux2to1 MM2_0(8'd0, outBus0, MemRead, MemBus0);
	MemMux2to1 MM2_1(8'd0, outBus1, MemRead, MemBus1);
endmodule


// ****************** D FF RF ***************************************

module D_ff_rF(input clk, input reset, input writeEn, input d, output reg q);
	always @ (negedge clk)
	begin
		if(reset==1)		q=0;
		else
			if(writeEn==1)	q=d;	
	end
endmodule


// ****************** 16bit Register ***************************************

module Register16bit(input clk, input reset, input writeEn, input [15:0] writeData, output  [15:0] outR);
	D_ff_rF d00(clk, reset, writeEn, writeData[0], outR[0]);
	D_ff_rF d01(clk, reset, writeEn, writeData[1], outR[1]);
	D_ff_rF d02(clk, reset, writeEn, writeData[2], outR[2]);
	D_ff_rF d03(clk, reset, writeEn, writeData[3], outR[3]);
	D_ff_rF d04(clk, reset, writeEn, writeData[4], outR[4]);
	D_ff_rF d05(clk, reset, writeEn, writeData[5], outR[5]);
	D_ff_rF d06(clk, reset, writeEn, writeData[6], outR[6]);
	D_ff_rF d07(clk, reset, writeEn, writeData[7], outR[7]);
	D_ff_rF d08(clk, reset, writeEn, writeData[8], outR[8]);
	D_ff_rF d09(clk, reset, writeEn, writeData[9], outR[9]);
	D_ff_rF d10(clk, reset, writeEn, writeData[10], outR[10]);
	D_ff_rF d11(clk, reset, writeEn, writeData[11], outR[11]);
	D_ff_rF d12(clk, reset, writeEn, writeData[12], outR[12]);
	D_ff_rF d13(clk, reset, writeEn, writeData[13], outR[13]);
	D_ff_rF d14(clk, reset, writeEn, writeData[14], outR[14]);
	D_ff_rF d15(clk, reset, writeEn, writeData[15], outR[15]);
endmodule


// ****************** 3bit Register ***************************************

module Register3bit(input clk, input reset, input writeEn, input [2:0] writeData, output  [2:0] outR);
	D_ff_rF d00(clk, reset, writeEn, writeData[0], outR[0]);
	D_ff_rF d01(clk, reset, writeEn, writeData[1], outR[1]);
	D_ff_rF d02(clk, reset, writeEn, writeData[2], outR[2]);
endmodule


// ****************** 1bit Register ***************************************

module Register1bit(input clk, input reset, input writeEn, input writeData, output  outR);
	D_ff_rF d00(clk, reset, writeEn, writeData, outR);
endmodule


// ****************** RegisterSet ***************************************

module RegisterSet(input clk, input reset, input regWrite, input [7:0] decOut, input [15:0] writeData,  output [15:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7 );
	Register16bit r0 (clk, reset, regWrite&decOut[0], writeData, outR0);
	Register16bit r1 (clk, reset, regWrite&decOut[1], writeData, outR1);
	Register16bit r2 (clk, reset, regWrite&decOut[2], writeData, outR2);
	Register16bit r3 (clk, reset, regWrite&decOut[3], writeData, outR3);
	Register16bit r4 (clk, reset, regWrite&decOut[4], writeData, outR4);
	Register16bit r5 (clk, reset, regWrite&decOut[5], writeData, outR5);
	Register16bit r6 (clk, reset, regWrite&decOut[6], writeData, outR6);
	Register16bit r7 (clk, reset, regWrite&decOut[7], writeData, outR7);
endmodule


// ****************** 3to8 DECODER ***************************************

module Dec3to8(input [2:0] destReg, output reg [7:0] decOut);
	always@(destReg)
	case(destReg)
			3'b000: decOut=8'b00000001; 
			3'b001: decOut=8'b00000010;
			3'b010: decOut=8'b00000100;
			3'b011: decOut=8'b00001000;
			3'b100: decOut=8'b00010000;
			3'b101: decOut=8'b00100000;
			3'b110: decOut=8'b01000000;
			3'b111: decOut=8'b10000000;
	endcase	
endmodule


// ****************** 8:1 16bit MUX ***************************************

module Mux8to1(input [15:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7, input [2:0] Sel, output reg [15:0] outBus );	
	always@(outR0 or outR1 or outR2 or outR3 or outR4 or outR5 or outR6 or outR7 or Sel)
		case (Sel)
			3'b000: outBus=outR0;
			3'b001: outBus=outR1;
			3'b010: outBus=outR2;
			3'b011: outBus=outR3;
			3'b100: outBus=outR4;
			3'b101: outBus=outR5;
			3'b110: outBus=outR6;
			3'b111: outBus=outR7;
		endcase	
endmodule


// ****************** Register FILE ***************************************

module RegisterFile(input clk, input reset, input regWrite, input [2:0] srcRegA, input [2:0] srcRegB,  input [2:0] destReg,  input [15:0] writeData, output [15:0] outBusA, output [15:0] outBusB );
	wire [7:0] decOut;
	wire [15:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7;
	Dec3to8 d0 (destReg,decOut);
	RegisterSet rSet0( clk, reset, regWrite, decOut, writeData, outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7);
	Mux8to1 m1(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,srcRegA,outBusA);
	Mux8to1 m2(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,srcRegB,outBusB);
endmodule


// ****************** Sign EXTENDED ***************************************

module SignExt8to16(input [7:0] in, output  reg [15:0] SignExtOut);
	always@(in)	SignExtOut={{8{in[7]}},in[7:0]};
endmodule


// ****************** ALU ***************************************

module ALU(input [15:0] in1, input [15:0] in2, input ALUOp, output reg [15:0] ALUOut);
	always@(in1, in2, ALUOp)
		case(ALUOp)
			1'b0:	ALUOut=in1+in2;	1'b1:	ALUOut=in1-in2;
		endcase
endmodule


// ****************** PC ADDER ***************************************

module PCadder(input [15:0] in, output reg [15:0] out);
	always@(in)
		out=in+2;
endmodule


// ****************** 2:1 16bit MUX ***************************************


module Mux2to1_16bits(input [15:0] in1, input [15:0] in2, input Sel,  output reg [15:0] MuxOut);	

	//Write your code here
	always@(in1 or in2 or Sel)
		case (Sel)
			1'b0: MuxOut = in1;
			1'b1: MuxOut = in2; 
		endcase	
	
endmodule



// ****************** 2:1 3bit MUX ***************************************

module Mux2to1_3bits(input [2:0] in1, input [2:0] in2, input Sel,  output reg [2:0] MuxOut);	

	//Write your code here
	always@(in1 or in2 or Sel)
	case(Sel)
	  1'b0:  MuxOut = in1;
	  1'b1:  MuxOut = in2;
	  endcase
	
endmodule


// ****************** IF/ID PIPELINE ***************************************

module IF_ID_PipelineRegister(input clk, input reset, input regWrite, input [15:0] instr, output [15:0] IR);

	//Write your code here
	Register16bit if_id_reg(clk, reset, regWrite , instr, IR);
	
endmodule


// ****************** ID/EX PIEPELINE ***************************************

module ID_EX_PipelineRegister(input clk, input reset, input regWrite, input [15:0] BusA, input [15:0] BusB, input [15:0] SignExt8to16Imm, input [2:0] rd, input [2:0] rt, input ALUSrcB, input ALUOp, input RegDst, input MemRead, input MemWrite, input MemToReg, input RegWrite, output [15:0] P2BusA, output [15:0] P2BusB, output [15:0] P2SignExt8to16Imm, output [2:0] P2rd, output [2:0] P2rt, output P2ALUSrcB, output P2ALUOp, output P2RegDst, output P2MemRead, output P2MemWrite, output P2MemToReg, output P2RegWrite);

	//Write your code here
	//Register1bit(input clk, input reset, input writeEn, input writeData, output  outR);
	//Register3bit(input clk, input reset, input writeEn, input [2:0] writeData, output  [2:0] outR);

  Register16bit id_ex_reg1(clk, reset, regWrite , BusA, P2BusA);
  Register16bit id_ex_reg2(clk, reset, regWrite , BusB, P2BusB);
  Register16bit id_ex_reg3(clk, reset, regWrite , SignExt8to16Imm, P2SignExt8to16Imm);
  
  Register3bit  id_ex_reg4(clk,  reset, regWrite,  rd, P2rd);
  Register3bit  id_ex_reg5(clk,  reset, regWrite,  rt, P2rt);
  
  //check for spelling mistakes
  
  Register1bit  id_ex_reg6( clk,  reset,  regWrite,  ALUSrcB, P2ALUSrcB);
  Register1bit  id_ex_reg7( clk,  reset,  regWrite,  ALUOp, P2ALUOp);
  Register1bit  id_ex_reg8( clk,  reset,  regWrite,  RegDst, P2RegDst);
  Register1bit  id_ex_reg9( clk,  reset,  regWrite,  MemWrite, P2MemWrite);
  Register1bit  id_ex_reg10( clk,  reset,  regWrite,  MemRead, P2MemRead);
  Register1bit  id_ex_reg11( clk,  reset,  regWrite,  MemToReg, P2MemToReg);
  Register1bit  id_ex_reg12( clk,  reset,  regWrite,  RegWrite, P2RegWrite);


endmodule


// ****************** EX/MEM PIPELINE ***************************************

module EX_MEM_PipelineRegister(input clk, input reset, input regWrite, input [15:0] ALUOut, input [15:0] BusB, input [2:0] DstReg, input MemRead, input MemWrite, input MemToReg, input RegWrite, output [15:0] P3ALUOut, output [15:0] P3BusB, output [2:0] P3DstReg, output P3MemRead, output P3MemWrite, output P3MemToReg, output P3RegWrite);	

	//Write your code here
	
	//check for spelling. ALSO, Error could be that i'm not using reset to put 0. Or regWrite?

	
	Register16bit ex_mem_reg1(clk, reset, regWrite , ALUOut, P3ALUOut);
  Register16bit ex_mem_reg2(clk, reset, regWrite , BusB, P3BusB);
  
  Register3bit  ex_mem_reg3(clk,  reset, regWrite,  DstReg, P3DstReg);
  
  Register1bit  ex_mem_reg4( clk,  reset,  regWrite,  MemRead, P3MemRead);
  Register1bit  ex_mem_reg5( clk,  reset,  regWrite,  MemWrite, P3MemWrite);
  Register1bit  ex_mem_reg6( clk,  reset,  regWrite,  MemToReg,P3MemToReg );
  Register1bit  ex_mem_reg7( clk,  reset,  regWrite,  RegWrite, P3RegWrite);
  
endmodule


// ****************** MEM/WB PIPELINE ***************************************

module MEM_WB_PipelineRegister(input clk, input reset, input regWrite, input [15:0] ALUOut, input [15:0] DMOut, input [2:0] DstReg, input RegWrite, input MemToReg, output [15:0] P4ALUOut, output [15:0] P4DMOut, output [2:0] P4DstReg, output P4RegWrite, output P4MemToReg);

	//Write your code here
	
	//input clk, input reset, input regWrite, input [15:0] ALUOut, input [15:0] DMOut, input [2:0] DstReg, 
	//input RegWrite, input MemToReg, output [15:0] P4ALUOut, output [15:0] P4DMOut, output [2:0] P4DstReg, 
	//output P4RegWrite, output P4MemToReg);

  Register16bit mem_wb_reg1(clk, reset, regWrite , ALUOut, P4ALUOut);
  Register16bit mem_wb_reg2(clk, reset, regWrite , DMOut, P4DMOut);
  
  Register3bit  mem_wb_reg3(clk,  reset, regWrite,  DstReg, P4DstReg);
  
  Register1bit  mem_wb_reg4( clk,  reset,  regWrite,  RegWrite, P4RegWrite);
  Register1bit  mem_wb_reg5( clk,  reset,  regWrite,  MemToReg, P4MemToReg);  
  
  
	
endmodule


// ****************** CONTROL CIRCUIT ***************************************

module CtrlCkt(input [1:0] opcode, input funcCode, output reg ALUSrcB, output reg ALUOp, output reg RegDst, output reg MemRead, output reg MemWrite, output reg MemToReg, output reg RegWrite);
	//Write your code here
	always@(opcode or funcCode)
  begin
  case(opcode)
    2'b00:begin RegDst = 1'b0; ALUSrcB = 1'b1; ALUOp = 1'b0; MemRead = 1'b1; MemWrite = 1'b0; MemToReg = 1'b1; RegWrite = 1'b1; end
    2'b01:begin RegDst = 1'b0; ALUSrcB = 1'b1; ALUOp = 1'b0; MemRead = 1'b0; MemWrite = 1'b1; MemToReg = 1'b0; RegWrite = 1'b0; end
    2'b10:begin RegDst = 1'b0; ALUSrcB = 1'b1; ALUOp = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1; end
    2'b11:begin
          if(funcCode == 1'b0)  begin 
            RegDst = 1'b1; ALUSrcB = 1'b0; ALUOp = 1'b0; MemRead = 1'b0; MemWrite = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1;
          end
          else  begin  
          RegDst = 1'b1; ALUSrcB = 1'b0; ALUOp = 1'b1; MemRead = 1'b0; MemWrite = 1'b0; MemToReg = 1'b0; RegWrite = 1'b1;
          end
        end           
  endcase
  end
endmodule


// ****************** TOP MODULE ***************************************

module TopModule(input clk, input reset, output [15:0] RegWriteData);
	
	//Instruction Memory initialization values init0 to init7 {16'hA00F,16'h310E,16'h9207,16'hE5C1,16'h600C,16'hE480,16'hC160,16'h0000}
	//Data Memory initialization values init0 to init7 {16'h0001,16'h0002,16'h0003,16'h0004,16'h0005,16'h0006,16'h0007,16'h0008}
	//Write your code here
	
	
	wire [7:0] pcAdd, pcPlusAdd,memBus0a,memBus1a;
	wire [15:0] pcInput,pcOutput,IRval,outBusA1,outBusB1,SignExtOut1,P4ALUOut1, P4DMOut1, P2BusA1,P2BusB1,P2SignExt8to16Imm1,aluInput2,ALUOut1,P3ALUOut1, P3BusB1;
	wire ALUSrcB1,ALUOp1,RegDst1,MemRead1,MemWrite1,P4RegWrite1, P4MemToReg1,MemToReg1,RegWrite1,P2ALUOp1,P2RegDst1,P2MemRead1,P2MemWrite1,P2MemToReg1,P2RegWrite1,P3MemRead1, P3MemWrite1,  P3MemToReg1,  P3RegWrite1;
	wire [2:0] P2rd1,P2rt1,finalDstReg,P3DstReg1,P4DstReg1;
	
	
	Register16bit pcReg(clk, reset, 1'b1 , pcInput, pcOutput); //correct.
	PCadder pcAddr(pcOutput, pcInput); //correct.
	//add pc ka initialization.
	Memory im1(clk, reset, 16'hA00F,16'h310E,16'h9207,16'hE5C1,16'h600C,16'hE480,16'hC160,16'h0000, 1'b0, 1'b1, pcOutput , 16'd0, pcAdd, pcPlusAdd);
	//correct.
		
	IF_ID_PipelineRegister p1( clk,  reset, 1'b1, {pcPlusAdd,pcAdd}, IRval); //correct.
	
	CtrlCkt ctrlCkt1(IRval[15:14], IRval[0], ALUSrcB1, ALUOp1, RegDst1, MemRead1, MemWrite1, MemToReg1, RegWrite1);  
	
	//passing the regWrite control sig here. It created trouble. So changed to 1'b1. :/ But that's not correct. But it gives right output only then. :/
	RegisterFile regFile1(clk, reset, P4RegWrite1, IRval[13:11], IRval[10:8],  P4DstReg1 ,  RegWriteData, outBusA1, outBusB1 );
	
  
  SignExt8to16 sgnExt1(IRval[7:0], SignExtOut1);
  
  

	ID_EX_PipelineRegister p2( clk, reset, 1'b1, outBusA1, outBusB1, SignExtOut1, IRval[7:5], IRval[10:8], ALUSrcB1,  ALUOp1,  RegDst1,  MemRead1,  MemWrite1,  MemToReg1,  RegWrite1, P2BusA1, P2BusB1, P2SignExt8to16Imm1,P2rd1, P2rt1, P2ALUSrcB1,  P2ALUOp1,  P2RegDst1,  P2MemRead1,  P2MemWrite1, P2MemToReg1,  P2RegWrite1);
  
  
  
  Mux2to1_16bits mux2to116(P2BusB1, P2SignExt8to16Imm1, P2ALUSrcB1,  aluInput2);
  
  	
	ALU alu1(P2BusA1, aluInput2, P2ALUOp1, ALUOut1);
	
	Mux2to1_3bits mux2to13(P2rt1, P2rd1, P2RegDst1,  finalDstReg);
	
	
	EX_MEM_PipelineRegister p3(clk, reset, 1'b1, ALUOut1, P2BusB1,finalDstReg, P2MemRead1, P2MemWrite1,  P2MemToReg1,  P2RegWrite1, P3ALUOut1, P3BusB1, P3DstReg1,  P3MemRead1, P3MemWrite1,  P3MemToReg1,  P3RegWrite1);	
	
	Memory dm1(clk, reset, 16'h0001,16'h0002,16'h0003,16'h0004,16'h0005,16'h0006,16'h0007,16'h0008, P3MemWrite1, P3MemRead1, P3ALUOut1 , P3BusB1, memBus0a, memBus1a);
	
		
	MEM_WB_PipelineRegister p4(clk, reset, 1'b1, P3ALUOut1, {memBus1a,memBus0a}, P3DstReg1, P3RegWrite1, P3MemToReg1, P4ALUOut1, P4DMOut1, P4DstReg1,  P4RegWrite1, P4MemToReg1);
	
	Mux2to1_16bits mux2to1162(P4ALUOut1, P4DMOut1, P4MemToReg1,  RegWriteData);
	
	
	
	
endmodule	


// ****************** TESTBENCH ***************************************

module testBench;
	reg clk, reset;
	wire [15:0] RegWriteData;
	TopModule uut (.clk(clk), .reset(reset), .RegWriteData(RegWriteData));
	always	#5 clk=~clk;	
	initial begin
		clk = 0; reset = 1; 		
		#10 reset=0;
		#130 $finish;
	end
endmodule






