// ========= 32 BIT SHIFTER ===============

module mux2x1( input [2:0] in0, input [2:0] in1, input sel, output reg [2:0] muxOut);
  always@(sel or in0 or in1)
  case(sel)
    1'b0:     muxOut=in0;
    1'b1:     muxOut=in1;
  endcase
endmodule

module mux8x1( input in0, input in1, input in2, input in3, input in4, input in5, input [2:0] sel, output reg muxOut);
  always@(sel or in0 or in1 or in2 or in3 or in4 or in5)
    case(sel)
      3'b000: muxOut=in0;
      3'b001: muxOut=in1;
      3'b010: muxOut=in2;
      3'b011: muxOut=in3;
      3'b100: muxOut=in4;
      3'b101: muxOut=in5;
      3'b110: muxOut=1'b0;
      3'b111: muxOut=1'b0;
    endcase
endmodule

module shifter32b(input [31:0] rs, input [4:0] shiftAmt, input [2:0] opcode, output [31:0] shiftOut);
  
  wire [2:0]muxsel1, muxsel2, muxsel3, muxsel4, muxsel5;
  wire [31:0]s,r,q,p;
    
  mux2x1 x1(3'b000,opcode,shiftAmt[0],muxsel1);
  mux2x1 x2(3'b000,opcode,shiftAmt[1],muxsel2);
  mux2x1 x3(3'b000,opcode,shiftAmt[2],muxsel3);
  mux2x1 x4(3'b000,opcode,shiftAmt[3],muxsel4);
  mux2x1 x5(3'b000,opcode,shiftAmt[4],muxsel5);
  
  //First stage
  mux8x1 mux311(rs[31],rs[31],1'b0,rs[0],rs[30],rs[30],muxsel1,s[31]);
  mux8x1 mux301(rs[30],rs[31],rs[31],rs[31],rs[29],rs[29],muxsel1,s[30]);
  mux8x1 mux291(rs[29],rs[30],rs[30],rs[30],rs[28],rs[28],muxsel1,s[29]);
  mux8x1 mux281(rs[28],rs[29],rs[29],rs[29],rs[27],rs[27],muxsel1,s[28]);
  mux8x1 mux271(rs[27],rs[28],rs[28],rs[28],rs[26],rs[26],muxsel1,s[27]);
  mux8x1 mux261(rs[26],rs[27],rs[27],rs[27],rs[25],rs[25],muxsel1,s[26]);
  mux8x1 mux251(rs[25],rs[26],rs[26],rs[26],rs[24],rs[24],muxsel1,s[25]);
  mux8x1 mux241(rs[24],rs[25],rs[25],rs[25],rs[23],rs[23],muxsel1,s[24]);
  mux8x1 mux231(rs[23],rs[24],rs[24],rs[24],rs[22],rs[22],muxsel1,s[23]);
  mux8x1 mux221(rs[22],rs[23],rs[23],rs[23],rs[21],rs[21],muxsel1,s[22]);
  mux8x1 mux211(rs[21],rs[22],rs[22],rs[22],rs[20],rs[20],muxsel1,s[21]);
  mux8x1 mux201(rs[20],rs[21],rs[21],rs[21],rs[19],rs[19],muxsel1,s[20]);
  mux8x1 mux191(rs[19],rs[20],rs[20],rs[20],rs[18],rs[18],muxsel1,s[19]);
  mux8x1 mux181(rs[18],rs[19],rs[19],rs[19],rs[17],rs[30],muxsel1,s[18]);
  mux8x1 mux171(rs[17],rs[18],rs[18],rs[18],rs[16],rs[16],muxsel1,s[17]);
  mux8x1 mux161(rs[16],rs[17],rs[17],rs[17],rs[15],rs[15],muxsel1,s[16]);
  mux8x1 mux151(rs[15],rs[16],rs[16],rs[16],rs[14],rs[14],muxsel1,s[15]);
  mux8x1 mux141(rs[14],rs[15],rs[15],rs[15],rs[13],rs[13],muxsel1,s[14]);
  mux8x1 mux131(rs[13],rs[14],rs[14],rs[14],rs[12],rs[12],muxsel1,s[13]);
  mux8x1 mux121(rs[12],rs[13],rs[13],rs[13],rs[11],rs[11],muxsel1,s[12]);
  mux8x1 mux111(rs[11],rs[12],rs[12],rs[12],rs[10],rs[10],muxsel1,s[11]);
  mux8x1 mux101(rs[10],rs[11],rs[11],rs[11],rs[09],rs[09],muxsel1,s[10]);
  mux8x1 mux091(rs[09],rs[10],rs[10],rs[10],rs[08],rs[08],muxsel1,s[9]);
  mux8x1 mux081(rs[08],rs[09],rs[09],rs[09],rs[07],rs[07],muxsel1,s[8]);
  mux8x1 mux071(rs[07],rs[08],rs[08],rs[08],rs[06],rs[06],muxsel1,s[7]);
  mux8x1 mux061(rs[06],rs[07],rs[07],rs[07],rs[05],rs[05],muxsel1,s[6]);
  mux8x1 mux051(rs[05],rs[06],rs[06],rs[06],rs[04],rs[04],muxsel1,s[5]);
  mux8x1 mux041(rs[04],rs[05],rs[05],rs[05],rs[03],rs[03],muxsel1,s[4]);
  mux8x1 mux031(rs[03],rs[04],rs[04],rs[04],rs[02],rs[02],muxsel1,s[3]);
  mux8x1 mux021(rs[02],rs[03],rs[03],rs[03],rs[01],rs[01],muxsel1,s[2]);
  mux8x1 mux011(rs[01],rs[02],rs[02],rs[02],rs[00],rs[00],muxsel1,s[1]);
  mux8x1 mux001(rs[00],rs[01],rs[01],rs[01],rs[31],rs[31],muxsel1,s[0]);
  
  //Second stage
  mux8x1 mux312(s[31],s[31],1'b0,s[1],s[29],s[29],muxsel2,r[31]);
  mux8x1 mux302(s[30],s[31],1'b0,s[0],s[28],s[28],muxsel2,r[30]);
  mux8x1 mux292(s[29],s[31],s[31],s[31],s[27],s[27],muxsel2,r[29]);
  mux8x1 mux282(s[28],s[30],s[30],s[30],s[26],s[26],muxsel2,r[28]);
  mux8x1 mux272(s[27],s[29],s[29],s[29],s[25],s[25],muxsel2,r[27]);
  mux8x1 mux262(s[26],s[28],s[28],s[28],s[24],s[24],muxsel2,r[26]);
  mux8x1 mux252(s[25],s[27],s[27],s[27],s[23],s[23],muxsel2,r[25]);
  mux8x1 mux242(s[24],s[26],s[26],s[26],s[22],s[22],muxsel2,r[24]);
  mux8x1 mux232(s[23],s[25],s[25],s[25],s[21],s[21],muxsel2,r[23]);
  mux8x1 mux222(s[22],s[24],s[24],s[24],s[20],s[20],muxsel2,r[22]);
  mux8x1 mux212(s[21],s[23],s[23],s[23],s[19],s[19],muxsel2,r[21]);  
  mux8x1 mux202(s[20],s[22],s[22],s[22],s[18],s[18],muxsel2,r[20]);
  mux8x1 mux192(s[19],s[21],s[21],s[21],s[17],s[17],muxsel2,r[19]);
  mux8x1 mux182(s[18],s[20],s[20],s[20],s[16],s[16],muxsel2,r[18]);
  mux8x1 mux172(s[17],s[19],s[19],s[19],s[15],s[15],muxsel2,r[17]);
  mux8x1 mux162(s[16],s[18],s[18],s[18],s[14],s[14],muxsel2,r[16]);
  mux8x1 mux152(s[15],s[17],s[17],s[17],s[13],s[13],muxsel2,r[15]);
  mux8x1 mux142(s[14],s[16],s[16],s[16],s[12],s[12],muxsel2,r[14]);
  mux8x1 mux132(s[13],s[15],s[15],s[15],s[11],s[11],muxsel2,r[13]);
  mux8x1 mux122(s[12],s[14],s[14],s[14],s[10],s[10],muxsel2,r[12]);
  mux8x1 mux112(s[11],s[13],s[13],s[13],s[09],s[09],muxsel2,r[11]);
  mux8x1 mux102(s[10],s[12],s[12],s[12],s[08],s[08],muxsel2,r[10]);
  mux8x1 mux092(s[09],s[11],s[11],s[11],s[07],s[07],muxsel2,r[9]);
  mux8x1 mux082(s[09],s[10],s[10],s[10],s[06],s[06],muxsel2,r[8]);
  mux8x1 mux072(s[07],s[09],s[09],s[09],s[05],s[05],muxsel2,r[7]);
  mux8x1 mux062(s[06],s[08],s[08],s[08],s[04],s[04],muxsel2,r[6]);
  mux8x1 mux052(s[05],s[07],s[07],s[07],s[03],s[03],muxsel2,r[5]);
  mux8x1 mux042(s[04],s[06],s[06],s[06],s[02],s[02],muxsel2,r[4]);
  mux8x1 mux032(s[03],s[05],s[05],s[05],s[01],s[01],muxsel2,r[3]);
  mux8x1 mux022(s[02],s[04],s[04],s[04],s[00],s[00],muxsel2,r[2]);
  mux8x1 mux012(s[01],s[03],s[03],s[03],1'b0,s[31],muxsel2,r[1]);
  mux8x1 mux002(s[00],s[02],s[02],s[02],1'b0,s[30],muxsel2,r[0]);
  
  //Third stage
  
  mux8x1 mux313(r[31],r[31],1'b0,r[03],r[27],r[27],muxsel3,q[31]);
  mux8x1 mux303(r[30],r[31],1'b0,r[02],r[26],r[26],muxsel3,q[30]);
  mux8x1 mux293(r[29],r[31],1'b0,r[01],r[25],r[25],muxsel3,q[29]);
  mux8x1 mux283(r[28],r[31],1'b0,r[00],r[24],r[24],muxsel3,q[28]);
  mux8x1 mux273(r[27],r[31],r[31],r[31],r[23],r[23],muxsel3,q[27]);
  mux8x1 mux263(r[26],r[30],r[30],r[30],r[22],r[22],muxsel3,q[26]);
  mux8x1 mux253(r[25],r[29],r[29],r[29],r[21],r[21],muxsel3,q[25]);
  mux8x1 mux243(r[24],r[28],r[28],r[28],r[20],r[20],muxsel3,q[24]);
  mux8x1 mux233(r[23],r[27],r[27],r[27],r[19],r[19],muxsel3,q[23]);
  mux8x1 mux223(r[22],r[26],r[26],r[26],r[18],r[18],muxsel3,q[22]);
  mux8x1 mux213(r[21],r[25],r[25],r[25],r[17],r[17],muxsel3,q[21]);
  mux8x1 mux203(r[20],r[24],r[24],r[24],r[16],r[16],muxsel3,q[20]);
  mux8x1 mux193(r[19],r[23],r[23],r[23],r[15],r[15],muxsel3,q[19]);
  mux8x1 mux183(r[18],r[22],r[22],r[22],r[14],r[14],muxsel3,q[18]);
  mux8x1 mux173(r[17],r[21],r[21],r[21],r[13],r[13],muxsel3,q[17]);
  mux8x1 mux163(r[16],r[20],r[20],r[20],r[12],r[12],muxsel3,q[16]);
  mux8x1 mux153(r[15],r[19],r[19],r[19],r[11],r[11],muxsel3,q[15]);
  mux8x1 mux143(r[14],r[18],r[18],r[18],r[10],r[10],muxsel3,q[14]);
  mux8x1 mux133(r[13],r[17],r[17],r[17],r[09],r[09],muxsel3,q[13]);
  mux8x1 mux123(r[12],r[16],r[16],r[16],r[08],r[08],muxsel3,q[12]);
  mux8x1 mux113(r[11],r[15],r[15],r[15],r[07],r[07],muxsel3,q[11]);
  mux8x1 mux103(r[10],r[14],r[14],r[14],r[06],r[06],muxsel3,q[10]);
  mux8x1 mux093(r[09],r[13],r[13],r[13],r[05],r[05],muxsel3,q[9]);
  mux8x1 mux083(r[08],r[12],r[12],r[12],r[04],r[04],muxsel3,q[8]);
  mux8x1 mux073(r[07],r[11],r[11],r[11],r[03],r[03],muxsel3,q[7]);
  mux8x1 mux063(r[06],r[10],r[10],r[10],r[02],r[02],muxsel3,q[6]);
  mux8x1 mux053(r[05],r[09],r[09],r[09],r[01],r[01],muxsel3,q[5]);
  mux8x1 mux043(r[04],r[08],r[08],r[08],r[00],r[00],muxsel3,q[4]);
  mux8x1 mux033(r[03],r[07],r[07],r[07],1'b0,r[31],muxsel3,q[3]);
  mux8x1 mux023(r[02],r[06],r[06],r[06],1'b0,r[30],muxsel3,q[2]);
  mux8x1 mux013(r[01],r[05],r[05],r[05],1'b0,r[29],muxsel3,q[1]);
  mux8x1 mux003(r[00],r[04],r[04],r[04],1'b0,r[28],muxsel3,q[0]);
  
   //Fourth stage
  
  mux8x1 mux314(q[31],q[31],1'b0,q[07],q[23],q[23],muxsel4,p[31]);
  mux8x1 mux304(q[30],q[31],1'b0,q[06],q[22],q[22],muxsel4,p[30]);
  mux8x1 mux294(q[29],q[31],1'b0,q[05],q[21],q[21],muxsel4,p[29]);
  mux8x1 mux284(q[28],q[31],1'b0,q[04],q[20],q[20],muxsel4,p[28]);
  mux8x1 mux274(q[27],q[31],1'b0,q[03],q[19],q[19],muxsel4,p[27]);
  mux8x1 mux264(q[26],q[31],1'b0,q[02],q[18],q[18],muxsel4,p[26]);
  mux8x1 mux254(q[25],q[31],1'b0,q[01],q[17],q[17],muxsel4,p[25]);
  mux8x1 mux244(q[24],q[31],1'b0,q[00],q[16],q[16],muxsel4,p[24]);
  mux8x1 mux234(q[23],q[31],q[31],q[31],q[15],q[15],muxsel4,p[23]);
  mux8x1 mux224(q[22],q[30],q[30],q[30],q[14],q[14],muxsel4,p[22]);
  mux8x1 mux214(q[21],q[29],q[29],q[29],q[13],q[13],muxsel4,p[21]);
  mux8x1 mux204(q[20],q[28],q[28],q[28],q[12],q[12],muxsel4,p[20]);
  mux8x1 mux194(q[19],q[27],q[27],q[27],q[11],q[11],muxsel4,p[19]);
  mux8x1 mux184(q[18],q[26],q[26],q[26],q[10],q[10],muxsel4,p[18]);
  mux8x1 mux174(q[17],q[25],q[25],q[25],q[09],q[09],muxsel4,p[17]);
  mux8x1 mux164(q[16],q[24],q[24],q[24],q[08],q[08],muxsel4,p[16]);
  mux8x1 mux154(q[15],q[23],q[23],q[23],q[07],q[07],muxsel4,p[15]);
  mux8x1 mux144(q[14],q[22],q[22],q[22],q[06],q[06],muxsel4,p[14]);
  mux8x1 mux134(q[13],q[21],q[21],q[21],q[05],q[05],muxsel4,p[13]);
  mux8x1 mux124(q[12],q[20],q[20],q[20],q[04],q[04],muxsel4,p[12]);
  mux8x1 mux114(q[11],q[19],q[19],q[19],q[03],q[03],muxsel4,p[11]);
  mux8x1 mux104(q[10],q[18],q[18],q[18],q[02],q[02],muxsel4,p[10]);
  mux8x1 mux094(q[09],q[17],q[17],q[17],q[01],q[01],muxsel4,p[9]);
  mux8x1 mux084(q[08],q[16],q[16],q[16],q[00],q[00],muxsel4,p[8]);
  mux8x1 mux074(q[07],q[15],q[15],q[15],1'b0,q[31],muxsel4,p[7]);
  mux8x1 mux064(q[06],q[14],q[14],q[14],1'b0,q[30],muxsel4,p[6]);
  mux8x1 mux054(q[05],q[13],q[13],q[13],1'b0,q[29],muxsel4,p[5]);
  mux8x1 mux044(q[04],q[12],q[12],q[12],1'b0,q[28],muxsel4,p[4]);
  mux8x1 mux034(q[03],q[11],q[11],q[11],1'b0,q[27],muxsel4,p[3]);
  mux8x1 mux024(q[02],q[10],q[10],q[10],1'b0,q[26],muxsel4,p[2]);
  mux8x1 mux014(q[01],q[09],q[09],q[09],1'b0,q[25],muxsel4,p[1]);
  mux8x1 mux004(q[00],q[08],q[08],q[08],1'b0,q[24],muxsel4,p[0]);
  
  //Fifth stage
  
  mux8x1 mux315(p[31],p[31],1'b0,p[15],p[15],p[15],muxsel5,shiftOut[31]);
  mux8x1 mux305(p[30],p[31],1'b0,p[14],p[14],p[14],muxsel5,shiftOut[30]);
  mux8x1 mux295(p[29],p[31],1'b0,p[13],p[13],p[13],muxsel5,shiftOut[29]);
  mux8x1 mux285(p[28],p[31],1'b0,p[12],p[12],p[12],muxsel5,shiftOut[28]);
  mux8x1 mux275(p[27],p[31],1'b0,p[11],p[11],p[11],muxsel5,shiftOut[27]);
  mux8x1 mux265(p[26],p[31],1'b0,p[10],p[10],p[10],muxsel5,shiftOut[26]);
  mux8x1 mux255(p[25],p[31],1'b0,p[09],p[09],p[09],muxsel5,shiftOut[25]);
  mux8x1 mux245(p[24],p[31],1'b0,p[08],p[08],p[08],muxsel5,shiftOut[24]);
  mux8x1 mux235(p[23],p[31],1'b0,p[07],p[07],p[07],muxsel5,shiftOut[23]);
  mux8x1 mux225(p[22],p[31],1'b0,p[06],p[06],p[06],muxsel5,shiftOut[22]);
  mux8x1 mux215(p[21],p[31],1'b0,p[05],p[05],p[05],muxsel5,shiftOut[21]);
  mux8x1 mux205(p[20],p[31],1'b0,p[04],p[04],p[04],muxsel5,shiftOut[20]);
  mux8x1 mux195(p[19],p[31],1'b0,p[03],p[03],p[03],muxsel5,shiftOut[19]);
  mux8x1 mux185(p[18],p[31],1'b0,p[02],p[02],p[02],muxsel5,shiftOut[18]);
  mux8x1 mux175(p[17],p[31],1'b0,p[01],p[01],p[01],muxsel5,shiftOut[17]);
  mux8x1 mux165(p[16],p[31],1'b0,p[00],p[00],p[00],muxsel5,shiftOut[16]);
  mux8x1 mux155(p[15],p[31],p[31],p[31],1'b0,p[31],muxsel5,shiftOut[15]);
  mux8x1 mux145(p[14],p[30],p[30],p[30],1'b0,p[30],muxsel5,shiftOut[14]);
  mux8x1 mux135(p[13],p[29],p[29],p[29],1'b0,p[29],muxsel5,shiftOut[13]);
  mux8x1 mux125(p[12],p[28],p[28],p[28],1'b0,p[28],muxsel5,shiftOut[12]);
  mux8x1 mux115(p[11],p[27],p[27],p[27],1'b0,p[27],muxsel5,shiftOut[11]);
  mux8x1 mux105(p[10],p[26],p[26],p[26],1'b0,p[26],muxsel5,shiftOut[10]);
  mux8x1 mux095(p[09],p[25],p[25],p[25],1'b0,p[25],muxsel5,shiftOut[9]);
  mux8x1 mux085(p[08],p[24],p[24],p[24],1'b0,p[24],muxsel5,shiftOut[8]);
  mux8x1 mux075(p[07],p[23],p[23],p[23],1'b0,p[23],muxsel5,shiftOut[7]);
  mux8x1 mux065(p[06],p[22],p[22],p[22],1'b0,p[22],muxsel5,shiftOut[6]);
  mux8x1 mux055(p[05],p[21],p[21],p[21],1'b0,p[21],muxsel5,shiftOut[5]);
  mux8x1 mux045(p[04],p[20],p[20],p[20],1'b0,p[20],muxsel5,shiftOut[4]);
  mux8x1 mux035(p[03],p[19],p[19],p[19],1'b0,p[19],muxsel5,shiftOut[3]);
  mux8x1 mux025(p[02],p[18],p[18],p[18],1'b0,p[18],muxsel5,shiftOut[2]);
  mux8x1 mux015(p[01],p[17],p[17],p[17],1'b0,p[17],muxsel5,shiftOut[1]);
  mux8x1 mux005(p[00],p[16],p[16],p[16],1'b0,p[16],muxsel5,shiftOut[0]);
  

endmodule

// ========== INSTRUCTION MEMORY ===========


module D_ff_IM(input clk, input reset, input d, output reg q);
  always @ (reset or posedge clk)
    if(reset) q=d;
endmodule


module register_IM(input clk, input reset, input [15:0] d_in,output [15:0] q_out);
  D_ff_IM dIM0 (clk, reset, d_in[0], q_out[0]);
  D_ff_IM dIM1 (clk, reset, d_in[1], q_out[1]);
  D_ff_IM dIM2 (clk, reset, d_in[2], q_out[2]);
  D_ff_IM dIM3 (clk, reset, d_in[3], q_out[3]);
  D_ff_IM dIM4 (clk, reset, d_in[4], q_out[4]);
  D_ff_IM dIM5 (clk, reset, d_in[5], q_out[5]);
  D_ff_IM dIM6 (clk, reset, d_in[6], q_out[6]);
  D_ff_IM dIM7 (clk, reset, d_in[7], q_out[7]);
  D_ff_IM dIM8 (clk, reset, d_in[8], q_out[8]);
  D_ff_IM dIM9 (clk, reset, d_in[9], q_out[9]);
  D_ff_IM dIM10 (clk, reset, d_in[10], q_out[10]);
  D_ff_IM dIM11 (clk, reset, d_in[11], q_out[11]);
  D_ff_IM dIM12 (clk, reset, d_in[12], q_out[12]);
  D_ff_IM dIM13 (clk, reset, d_in[13], q_out[13]);
  D_ff_IM dIM14 (clk, reset, d_in[14], q_out[14]);
  D_ff_IM dIM15 (clk, reset, d_in[15], q_out[15]);
endmodule

module mux32to1( input [15:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,outR8,outR9,outR10,outR11,outR12,outR13,
outR14,outR15,outR16,outR17,outR18,outR19,outR20,outR21,outR22,outR23,outR24,outR25,outR26,outR27,outR28,outR29,
outR30,outR31,input [4:0] Sel,output reg [15:0] outBus );

  always@(outR0 or outR1 or outR2 or outR3 or outR4 or outR5 or outR6 or outR7 or outR8 or outR9 or outR10 or outR11 or outR12
or outR13 or outR14 or outR15 or outR16 or outR17 or outR18 or outR19 or outR20 or outR21 or outR22 or outR23 or outR24 or outR25 or
outR26 or outR27 or outR28 or outR29 or outR30 or outR31 or Sel)
  case (Sel)
    5'b00000: outBus=outR0; 5'b00001: outBus=outR1; 5'b00010: outBus=outR2; 5'b00011: outBus=outR3;
    5'b00100: outBus=outR4; 5'b00101: outBus=outR5; 5'b00110: outBus=outR6; 5'b00111: outBus=outR7;
    5'b01000: outBus=outR8; 5'b01001: outBus=outR9; 5'b01010: outBus=outR10; 5'b01011: outBus=outR11;
    5'b01100: outBus=outR12; 5'b01101: outBus=outR13; 5'b01110: outBus=outR14; 5'b01111: outBus=outR15;
    5'b10000: outBus=outR16; 5'b10001: outBus=outR17; 5'b10010: outBus=outR18; 5'b10011: outBus=outR19;
    5'b10100: outBus=outR20; 5'b10101: outBus=outR21; 5'b10110: outBus=outR22; 5'b10111: outBus=outR23;
    5'b11000: outBus=outR24; 5'b11001: outBus=outR25; 5'b11010: outBus=outR26; 5'b11011: outBus=outR27;
    5'b11100: outBus=outR28; 5'b11101: outBus=outR29; 5'b11110: outBus=outR30; 5'b11111: outBus=outR31;
  endcase
endmodule

module IM( input clk, input reset, input [31:0] pc, output [15:0] instr );
wire [15:0] Qout0, Qout1, Qout2, Qout3, Qout4, Qout5, Qout6, Qout7, Qout8, Qout9, Qout10, Qout11, Qout12, Qout13, Qout14, Qout15,
Qout16, Qout17, Qout18, Qout19, Qout20, Qout21, Qout22, Qout23, Qout24, Qout25, Qout26, Qout27, Qout28, Qout29, Qout30, Qout31;

  register_IM rIM0 (clk, reset, 16'b01_01_010000_000_001, Qout0); //addi $r1, $r0, 16
  register_IM rIM1 (clk, reset, 16'b01_01_000110_000_111, Qout1); //addi $r7, $r0, 6
  register_IM rIM2 (clk, reset, 16'b00_011_00101_001_001, Qout2); //csr $r1, $r1, 5
  register_IM rIM3 (clk, reset, 16'b00_010_11111_001_010, Qout3); //lsr $r2, $r1, 31
  register_IM rIM4 (clk, reset, 16'b00_001_00001_001_001, Qout4); //asr $r1, $r1, 1
  register_IM rIM5 (clk, reset, 16'b00_101_00010_001_001, Qout5); //csl $r1, $r1, 2
  register_IM rIM6 (clk, reset, 16'b00_100_00001_010_010, Qout6); //lsl $r2, $r2, 1
  register_IM rIM7 (clk, reset, 16'b01_00_000_011_011_010, Qout7); //add $r3, $r3, $r2
  register_IM rIM8 (clk, reset, 16'b01_11_000001_001_001, Qout8); //subi $r1, $r1, 1
  register_IM rIM9 (clk, reset, 16'b10_0000_0000_0000_01, Qout9); //bz 1
  register_IM rIM10 (clk, reset, 16'b11_0000_0000_111_000, Qout10); //jr $r7
  register_IM rIM11 (clk, reset, 16'b01_00_000_101_011_010, Qout11); //add $r5, $r3, $r2
  register_IM rIM12 (clk, reset, 16'b01_10_000_100_011_010, Qout12); //sub $r4, $r3, $r2
  register_IM rIM13 (clk, reset, 16'b01_11_000010_101_101, Qout13); //subi $r5, $r5, 2
  register_IM rIM14 (clk, reset, 16'b00_010_00001_101_110, Qout14); //lsr $r6, $r5, 1
  register_IM rIM15 (clk, reset, 16'b01_00_000_100_100_110, Qout15); //add $r4, $r4, $r6
  register_IM rIM16 (clk, reset, 16'b00_011_00001_010_001, Qout16); //csr $r1, $r2, 1
  register_IM rIM17 (clk, reset, 16'b01_01_111110_011_011, Qout17); //add $r3, $r3, -2
  register_IM rIM18 (clk, reset, 16'b00_100_00001_011_110, Qout18); //lsl $r0, $r3, 1
  register_IM rIM19 (clk, reset, 16'b01_00_000_111_110_001, Qout19); //add $r7, $r6, $r1
  register_IM rIM20 (clk, reset, 16'b01_00_000_000_000_000, Qout20); //add $r0, $r0, $r0
  register_IM rIM21 (clk, reset, 16'b0000000000000000, Qout21);
  register_IM rIM22 (clk, reset, 16'b0000000000000000, Qout22);
  register_IM rIM23 (clk, reset, 16'b0000000000000000, Qout23);
  register_IM rIM24 (clk, reset, 16'b0000000000000000, Qout24);
  register_IM rIM25 (clk, reset, 16'b0000000000000000, Qout25);
  register_IM rIM26 (clk, reset, 16'b0000000000000000, Qout26);
  register_IM rIM27 (clk, reset, 16'b0000000000000000, Qout27);
  register_IM rIM28 (clk, reset, 16'b0000000000000000, Qout28);
  register_IM rIM29 (clk, reset, 16'b0000000000000000, Qout29);
  register_IM rIM30 (clk, reset, 16'b0000000000000000, Qout30);
  register_IM rIM31 (clk, reset, 16'b0000000000000000, Qout31);
  
  mux32to1 mIM(Qout0,Qout1,Qout2,Qout3,Qout4,Qout5,Qout6,Qout7,Qout8,Qout9,Qout10,Qout11,Qout12,Qout13,Qout14,Qout15,Qout16,Qout17,Qout18,Qout19,Qout20,Qout21,Qout22,Qout23,Qout24,Qout25,Qout26,Qout27,Qout28,Qout29,Qout30,Qout31,pc[4:0],instr);

endmodule

// ===== REGISTER FILE =====================

module D_ff(input clk, input reset, input regWrite, input decOut1b, input d,output reg q);
  always@(negedge clk)
  begin
    if(reset==1)
      q=0;
    else
      if(regWrite == 1 && decOut1b == 1)
        begin
          q = d;
        end
  end
endmodule

module register32bit(input clk, input reset, input regWrite, input decOut1b,input[31:0] writeData, output [31:0] outR);
  D_ff a0(clk,reset,regWrite,decOut1b,writeData[0],outR[0]);
  D_ff a1(clk,reset,regWrite,decOut1b,writeData[1],outR[1]);
  D_ff a2(clk,reset,regWrite,decOut1b,writeData[2],outR[2]);
  D_ff a3(clk,reset,regWrite,decOut1b,writeData[3],outR[3]);
  D_ff a4(clk,reset,regWrite,decOut1b,writeData[4],outR[4]);
  D_ff a5(clk,reset,regWrite,decOut1b,writeData[5],outR[5]);
  D_ff a6(clk,reset,regWrite,decOut1b,writeData[6],outR[6]);
  D_ff a7(clk,reset,regWrite,decOut1b,writeData[7],outR[7]);
  D_ff a8(clk,reset,regWrite,decOut1b,writeData[8],outR[8]);
  D_ff a9(clk,reset,regWrite,decOut1b,writeData[9],outR[9]);
  D_ff a10(clk,reset,regWrite,decOut1b,writeData[10],outR[10]);
  D_ff a11(clk,reset,regWrite,decOut1b,writeData[11],outR[11]);
  D_ff a12(clk,reset,regWrite,decOut1b,writeData[12],outR[12]);
  D_ff a13(clk,reset,regWrite,decOut1b,writeData[13],outR[13]);
  D_ff a14(clk,reset,regWrite,decOut1b,writeData[14],outR[14]);
  D_ff a15(clk,reset,regWrite,decOut1b,writeData[15],outR[15]);
  D_ff a16(clk,reset,regWrite,decOut1b,writeData[16],outR[16]);
  D_ff a17(clk,reset,regWrite,decOut1b,writeData[17],outR[17]);
  D_ff a18(clk,reset,regWrite,decOut1b,writeData[18],outR[18]);
  D_ff a19(clk,reset,regWrite,decOut1b,writeData[19],outR[19]);
  D_ff a20(clk,reset,regWrite,decOut1b,writeData[20],outR[20]);
  D_ff a21(clk,reset,regWrite,decOut1b,writeData[21],outR[21]);
  D_ff a22(clk,reset,regWrite,decOut1b,writeData[22],outR[22]);
  D_ff a23(clk,reset,regWrite,decOut1b,writeData[23],outR[23]);
  D_ff a24(clk,reset,regWrite,decOut1b,writeData[24],outR[24]);
  D_ff a25(clk,reset,regWrite,decOut1b,writeData[25],outR[25]);
  D_ff a26(clk,reset,regWrite,decOut1b,writeData[26],outR[26]);
  D_ff a27(clk,reset,regWrite,decOut1b,writeData[27],outR[27]);
  D_ff a28(clk,reset,regWrite,decOut1b,writeData[28],outR[28]);
  D_ff a29(clk,reset,regWrite,decOut1b,writeData[29],outR[29]);
  D_ff a30(clk,reset,regWrite,decOut1b,writeData[30],outR[30]);
  D_ff a31(clk,reset,regWrite,decOut1b,writeData[31],outR[31]);
  
endmodule


module registerSet(input clk, input reset, input regWrite, input [7:0] decOut,input [31:0] writeData,output [31:0] outR0, outR1, outR2,outR3,outR4,outR5,outR6,outR7);
  register32bit r0(clk,reset,regWrite,decOut[0],writeData,outR0);
  register32bit r1(clk,reset,regWrite,decOut[1],writeData,outR1);
  register32bit r2(clk,reset,regWrite,decOut[2],writeData,outR2);
  register32bit r3(clk,reset,regWrite,decOut[3],writeData,outR3);
  register32bit r4(clk,reset,regWrite,decOut[4],writeData,outR4);
  register32bit r5(clk,reset,regWrite,decOut[5],writeData,outR5);
  register32bit r6(clk,reset,regWrite,decOut[6],writeData,outR6);
  register32bit r7(clk,reset,regWrite,decOut[7],writeData,outR7);
endmodule


module decoder(input[2:0] destReg, output reg [7:0] decOut);
  always@(destReg[0] or destReg[1] or destReg[2])
  begin
    case(destReg)
      3'b000: decOut = 8'b00000001;
      3'b001: decOut = 8'b00000010;
      3'b010: decOut = 8'b00000100;
      3'b011: decOut = 8'b00001000;
      3'b100: decOut = 8'b00010000;
      3'b101: decOut = 8'b00100000;
      3'b110: decOut = 8'b01000000;
      3'b111: decOut = 8'b10000000;
    endcase
  end
endmodule

module mux8to1(input [31:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,input [2:0] Sel,output reg [31:0] outBus);
  always @ (Sel or outR0 or outR1 or outR2 or outR3 or outR4 or outR5 or outR6 or outR7)
  begin
    case(Sel)
      3'b000: outBus = outR0;
      3'b001: outBus = outR1;
      3'b010: outBus = outR2;
      3'b011: outBus = outR3;
      3'b100: outBus = outR4;
      3'b101: outBus = outR5;
      3'b110: outBus = outR6;
      3'b111: outBus = outR7;
    endcase
  end
endmodule

module registerFile(input clk, input reset, input regWrite, input [2:0] srcRegA, input [2:0] srcRegB, input [2:0] destReg, input [31:0] writeData, output [31:0] outBusA, output [31:0] outBusB);
  wire [31:0] opR0,opR1, opR2, opR3, opR4, opR5, opR6, opR7;
  wire [7:0] decop;
  decoder d1(destReg,decop);
  registerSet a1(clk, reset, regWrite, decop,writeData,opR0,opR1,opR2,opR3,opR4,opR5,opR6,opR7);
  mux8to1 m1(opR0,opR1,opR2,opR3,opR4,opR5,opR6,opR7,srcRegA,outBusA);
  mux8to1 m2(opR0,opR1,opR2,opR3,opR4,opR5,opR6,opR7,srcRegB,outBusB);
endmodule


// =========  Multiplexers =============

module mux2to1_3bits(input [2:0] in1, input [2:0] in2, input sel, output reg [2:0] muxout);
  always @ (sel or in1 or in2)
  begin
    case(sel)
      1'b0: muxout = in1;
      1'b1: muxout = in2;
    endcase
  end
endmodule
    
module mux2to1_32bits(input [31:0] in1, input [31:0] in2, input sel, output reg [31:0] muxout);
  always @ (sel or in1 or in2)
  begin
    case(sel)
      1'b0: muxout = in1;
      1'b1: muxout = in2;
    endcase
  end
endmodule

// ================ Sign Extension ===============


module signExt6to32(input [5:0] offset, output reg [31:0] signExtOffset);
  always @ (offset)
  begin
      signExtOffset = {{26{offset[5]}},offset};
    end
endmodule

module signExt14to32(input [13:0] offset, output reg [31:0] signExtOffset);
  always @ (offset)
  begin
    signExtOffset = {{18{offset[13]}},offset};
  end
endmodule

// ================ ALU, Dedicated Adder and setZeroFlag ==========

module alu(input [31:0] aluIn1, input [31:0] aluIn2, input aluOp, output reg [31:0] aluResult);
  always @ (aluIn1 or aluIn2 or aluOp)
  begin
    case(aluOp)
      1'b0: aluResult = aluIn1 + aluIn2;
      1'b1: aluResult = aluIn1 - aluIn2;
    endcase
  end
endmodule

module adder(input [31:0] in1, input [31:0] in2, output reg [31:0] adder_out);
  always @ (in1 or in2)
  begin
    adder_out = in1 + in2;
  end
endmodule

module setZflag(input [31:0] Result, output reg zero);
  always @ (Result)
  begin
    if(Result == 32'd0) zero = 1'b1;
    else  zero = 1'b0;
  end
endmodule

// ======== Control Circuit =============

module ctrlCkt(input [4:0] opcode, output reg regDst, output reg regWrite, output reg aluSrc, output reg aluOp, output reg writeSrc, output reg branch, output reg jump);
  always @ (opcode)
  begin
    case(opcode)
      5'b00001:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b1; branch = 1'b0; jump = 1'b0; end
      5'b00010:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b1; branch = 1'b0; jump = 1'b0; end
      5'b00011:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b1; branch = 1'b0; jump = 1'b0; end
      5'b00100:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b1; branch = 1'b0; jump = 1'b0; end
      5'b00101:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b1; branch = 1'b0; jump = 1'b0; end
      //using 0 instead of don't care. Now for add/sub.
      5'b01000:  begin regDst = 1'b1; regWrite = 1'b1; aluSrc = 1'b0; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end
      5'b01001:  begin regDst = 1'b1; regWrite = 1'b1; aluSrc = 1'b0; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end  
      5'b01010:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end
      5'b01011:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end
      5'b01100:  begin regDst = 1'b1; regWrite = 1'b1; aluSrc = 1'b0; aluOp = 1'b1; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end
      5'b01101:  begin regDst = 1'b1; regWrite = 1'b1; aluSrc = 1'b0; aluOp = 1'b1; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end
      5'b01110:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b1; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end
      5'b01111:  begin regDst = 1'b0; regWrite = 1'b1; aluSrc = 1'b1; aluOp = 1'b1; writeSrc = 1'b0; branch = 1'b0; jump = 1'b0; end
      //now for jump
      5'b10000:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      5'b10001:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      5'b10010:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      5'b10011:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      5'b10100:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      5'b10101:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      5'b10110:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      5'b10111:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b1; jump = 1'b0; end
      
      5'b11000:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end
      5'b11001:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end
      5'b11010:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end
      5'b11011:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end
      5'b11100:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end
      5'b11101:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end
      5'b11110:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end
      5'b11111:  begin regDst = 1'b0; regWrite = 1'b0; aluSrc = 1'b1; aluOp = 1'b0; writeSrc = 1'b0; branch = 1'b0; jump = 1'b1; end

     endcase
   end
endmodule



// ========= TOP LEVEL MODULE ============

module singleCycle(input clk, input reset, output [31:0] Result);
  //intermediate inputs
  
  
  //intermediate ouputs
  wire [31:0] pcOutput,adder1Op,adder2Op,branchAdd,muxPc1,shifterOp,pcInput,outBusA,addiBusB,outBusB,aluBusB,aluOutput;
  wire [15:0] inst;
  wire [2:0] rdest;
  wire regDst, regWrite, aluSrc, aluOp, writeSrc, branch, jump;
  wire zeroFlag,zFlagValue;
  
  //make PC as a 32bit register. Since we always writing,so regWrite n decOut permanent 1.
  register32bit PCregister(clk,reset,1'b1,1'b1,pcInput,pcOutput);
  adder adder1(pcOutput, 32'd1,adder1Op);
  IM im(clk, reset, pcOutput, inst);
  
  //Ctrl circuit
  ctrlCkt contrlCkt(inst[15:11], regDst, regWrite, aluSrc, aluOp, writeSrc, branch, jump);
     
  signExt14to32 SignExtend14to32(inst[13:0],branchAdd);
  adder adder2(adder1Op,branchAdd,adder2Op);
  mux2to1_32bits MuxNum1(adder1Op,adder2Op,(zFlagValue & branch),muxPc1);
  mux2to1_32bits muxForFinalPC(muxPc1,outBusA,jump,pcInput);
  
  mux2to1_3bits muxForRd(inst[2:0],inst[8:6],regDst,rdest);
  registerFile registFile(clk, reset, regWrite, inst[5:3], inst[2:0],rdest,Result,outBusA, outBusB);
  
  alu aluUnit(outBusA,aluBusB, aluOp,aluOutput); 
  mux2to1_32bits muxForALUbusB(outBusB,addiBusB,aluSrc,aluBusB);
  signExt6to32 signExtend6to32(inst[11:6],addiBusB);
    
  shifter32b shifter32bit(outBusA,inst[10:6],inst[13:11],shifterOp);
  
  mux2to1_32bits muxForFinalResult(aluOutput,shifterOp,writeSrc,Result);
  
  D_ff zeroFlipFlop(clk,reset,regWrite,1'b1,zeroFlag,zFlagValue);
  setZflag setZeroFlag(Result,zeroFlag);
    
endmodule

module testBench;
  reg clk;
  reg reset;
  wire [31:0] Result;
  singleCycle uut(.clk(clk), .reset(reset), .Result(Result));
  always
   #5 clk=~clk;
  initial
  begin
    clk=0; reset=1;
    #5 reset=0;
    #300 $finish;
  end
endmodule