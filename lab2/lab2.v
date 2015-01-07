module alu( input [31:0] rs, input [31:0] rt, input [2:0] opCode, output reg [31:0] aluOut);
  always @(opCode)
  begin
    case(opCode)
      3'b000: aluOut=32'd0;
      3'b001: aluOut = rs+rt;
      3'b010: aluOut = rs-rt;
      3'b011: aluOut = rs&rt;
      3'b100: aluOut = rs|rt;
      3'b101: aluOut = ~rs;
    endcase
  end
endmodule


module mux2to1( input [2:0] in0, input [2:0] in1, input sel, output reg [2:0] muxOut);
always @(sel or in1)
  begin
    case(sel)
      1'b0:muxOut=in0;
      1'b1:muxOut=in1;
    endcase
  end
endmodule


module mux8to1( input in0, input in1, input in2, input in3, input in4, input in5, input [2:0] sel, output reg muxOut);
always @(sel or in0 or in1 or in2 or in3 or in4 or in5)
  begin
    case(sel)
      3'b000: muxOut=in0;
      3'b001: muxOut=in1;
      3'b010: muxOut=in2;
      3'b011: muxOut=in3;
      3'b100: muxOut=in4;
      3'b101: muxOut=in5;
      3'b110: muxOut=0;
      3'b111: muxOut=0;
    endcase
  end
endmodule


module shifter8bits( input [7:0] rs, input [2:0] shiftAmt, input [2:0] opCode, output [7:0] shiftOut);

wire [7:0] m1Out,m2Out;
wire [2:0] mbOut0,mbOut1,mbOut2;

mux2to1 mb0(3'b000,opCode,shiftAmt[0],mbOut0);
mux2to1 mb1(3'b000,opCode,shiftAmt[1],mbOut1);
mux2to1 mb2(3'b000,opCode,shiftAmt[2],mbOut2);

mux8to1 m10(rs[0],rs[1],rs[1],rs[1],1'b0,rs[7],mbOut0,m1Out[0]);
mux8to1 m11(rs[1],rs[2],rs[2],rs[2],rs[0],rs[0],mbOut0,m1Out[1]);
mux8to1 m12(rs[2],rs[3],rs[3],rs[3],rs[1],rs[1],mbOut0,m1Out[2]);
mux8to1 m13(rs[3],rs[4],rs[4],rs[4],rs[2],rs[2],mbOut0,m1Out[3]);
mux8to1 m14(rs[4],rs[5],rs[5],rs[5],rs[3],rs[3],mbOut0,m1Out[4]);
mux8to1 m15(rs[5],rs[6],rs[6],rs[6],rs[4],rs[4],mbOut0,m1Out[5]);
mux8to1 m16(rs[6],rs[7],rs[7],rs[7],rs[5],rs[5],mbOut0,m1Out[6]);
mux8to1 m17(rs[7],rs[7],1'b0,rs[0],rs[6],rs[6],mbOut0,m1Out[7]);

mux8to1 m20(m1Out[0],m1Out[2],m1Out[2],m1Out[2],1'b0,m1Out[6],mbOut1,m2Out[0]);
mux8to1 m21(m1Out[1],m1Out[3],m1Out[3],m1Out[3],1'b0,m1Out[7],mbOut1,m2Out[1]);
mux8to1 m22(m1Out[2],m1Out[4],m1Out[4],m1Out[4],m1Out[0],m1Out[0],mbOut1,m2Out[2]);
mux8to1 m23(m1Out[3],m1Out[5],m1Out[5],m1Out[5],m1Out[1],m1Out[1],mbOut1,m2Out[3]);
mux8to1 m24(m1Out[4],m1Out[6],m1Out[6],m1Out[6],m1Out[2],m1Out[2],mbOut1,m2Out[4]);
mux8to1 m25(m1Out[5],m1Out[7],m1Out[7],m1Out[7],m1Out[3],m1Out[3],mbOut1,m2Out[5]);
mux8to1 m26(m1Out[6],m1Out[7],1'b0,m1Out[0],m1Out[4],m1Out[4],mbOut1,m2Out[6]);
mux8to1 m27(m1Out[7],m1Out[7],1'b0,m1Out[1],m1Out[5],m1Out[5],mbOut1,m2Out[7]);

mux8to1 m30(m2Out[0],m2Out[4],m2Out[4],m2Out[4],1'b0,m2Out[4],mbOut2,shiftOut[0]);
mux8to1 m31(m2Out[1],m2Out[5],m2Out[5],m2Out[5],1'b0,m2Out[5],mbOut2,shiftOut[1]);
mux8to1 m32(m2Out[2],m2Out[6],m2Out[6],m2Out[6],1'b0,m2Out[6],mbOut2,shiftOut[2]);
mux8to1 m33(m2Out[3],m2Out[7],m2Out[7],m2Out[7],1'b0,m2Out[7],mbOut2,shiftOut[3]);
mux8to1 m34(m2Out[4],m2Out[7],1'b0,m2Out[0],m2Out[0],m2Out[0],mbOut2,shiftOut[4]);
mux8to1 m35(m2Out[5],m2Out[7],1'b0,m2Out[1],m2Out[1],m2Out[1],mbOut2,shiftOut[5]);
mux8to1 m36(m2Out[6],m2Out[7],1'b0,m2Out[2],m2Out[2],m2Out[2],mbOut2,shiftOut[6]);
mux8to1 m37(m2Out[7],m2Out[7],1'b0,m2Out[3],m2Out[3],m2Out[3],mbOut2,shiftOut[7]);

endmodule

module signExtender( input [7:0] shiftOut, output reg [31:0] signExtOut);
always @(shiftOut)
  begin
    case(shiftOut[7])
      1'b0:
      begin
        signExtOut[31:8]=24'd0;
        signExtOut[7:0]=shiftOut;
      end
      1'b1:
      begin
        signExtOut[31:8]=24'd1;
        signExtOut[7:0]=shiftOut;
      end
    endcase
  end
endmodule


module zeroExtender( input [7:0] shiftOut, output reg [31:0] zeroExtOut);
  always @(shiftOut)
  begin
    zeroExtOut[31:8]=24'd0;
    zeroExtOut[7:0]=shiftOut;
  end
endmodule

module mux4to1( input [31:0] zeroInput, input [31:0] ALUOut, input [31:0] signExtOut, input [31:0] zeroExtOut,input [1:0] selOut, output reg [31:0] finalOut);
always @(selOut or ALUOut or signExtOut or zeroExtOut)
  begin
    case(selOut)
      2'b00: finalOut=zeroInput;
      2'b01: finalOut=ALUOut;
      2'b10: finalOut=signExtOut;
      2'b11: finalOut=zeroExtOut;
    endcase
  end
endmodule


module shifterAndAlu( input [31:0] rs, input [31:0] rt, input [2:0] opCode, input [1:0] selOut, output [31:0] finalOut);

wire [31:0] aluOut,shiftOut,signOut,zeroOut;

alu a1(rs,rt,opCode,aluOut);
shifter8bits s1(rs[7:0],rt[2:0],opCode,shiftOut);
signExtender sn1(shiftOut,signOut);
zeroExtender zr1(shiftOut,zeroOut);
mux4to1 mx1(32'd0,aluOut,signOut,zeroOut,selOut,finalOut);

endmodule


module testBench();
//inputs
reg [31:0] rs, rt;
reg [2:0] opCode;
reg [1:0] selOut;
//outputs
wire [31:0] finalOut;
shifterAndAlu uut( rs, rt, opCode, selOut, finalOut);
initial
begin rs=32'd17; rt=32'd3; opCode=3'd1; selOut=2'd0;
$monitor("rs = %d, rt = %d, opCode = %d, selOut = %d, finalOut = %d", rs,rt,opCode,selOut,finalOut);
#10 selOut=2'd1;
#10 selOut=2'd1; opCode=3'd2;
#10 selOut=2'd1; opCode=3'd3;
#10 selOut=2'd1; opCode=3'd4;
#10 selOut=2'd1; opCode=3'd5;
#10 selOut=2'd2; opCode=3'd1;
#10 selOut=2'd2; opCode=3'd2;
#10 selOut=2'd2; opCode=3'd3;
#10 selOut=2'd2; opCode=3'd4;
#10 selOut=2'd2; opCode=3'd5;
#10 selOut=2'd3; opCode=3'd1;
#10 selOut=2'd3; opCode=3'd2;
#10 selOut=2'd3; opCode=3'd3;
#10 selOut=2'd3; opCode=3'd4;
#10 selOut=2'd3; opCode=3'd5;
#10 $finish;
end
endmodule
