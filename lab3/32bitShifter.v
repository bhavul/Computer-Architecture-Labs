module mux2x1( input [2:0] in0, input [2:0] in1, input sel, output reg [2:0] muxOut);
  always@(sel,in0,in1)
  case(sel)
    1'b0:     muxOut=in0;
    1'b1:     muxOut=in1;
  endcase
endmodule

module mux8x1( input in0, input in1, input in2, input in3, input in4, input in5, input [2:0] sel, output reg muxOut);
  always@(sel,in0,in1,in2,in3,in4,in5)
    case(sel)
      3'b000:     muxOut=in0;
      3'b001:     muxOut=in1;
      3'b010:     muxOut=in2;
      3'b011:     muxOut=in3;
      3'b100:     muxOut=in4;
      3'b101:     muxOut=in5;
      3'b110:     muxOut=1'b0;
      3'b111:     muxOut=1'b0;
    endcase
endmodule

module shifter32bit( input [31:0] b, input [2:0] opCode, input [4:0] shiftAmt, output [31:0] o );
  
  wire [2:0]muxsel1;
  wire [2:0]muxsel2;
  wire [2:0]muxsel3;
  wire [2:0]muxsel4;
  wire [2:0]muxsel5;
  wire [31:0]s;
  wire [31:0]r;
  wire [31:0]q;
  wire [31:0]p;
    
  mux2x1 x1(000,opCode,shiftAmt[0],muxsel1);
  mux2x1 x2(000,opCode,shiftAmt[1],muxsel2);
  mux2x1 x3(000,opCode,shiftAmt[2],muxsel3);
  mux2x1 x4(000,opCode,shiftAmt[3],muxsel4);
  mux2x1 x5(000,opCode,shiftAmt[4],muxsel5);
  
  //First stage
  mux8x1 mux311(b[31],b[31],0,b[0],b[30],b[30],muxsel1,s[31]);
  mux8x1 mux301(b[30],b[31],b[31],b[31],b[29],b[29],muxsel1,s[30]);
  mux8x1 mux291(b[29],b[30],b[30],b[30],b[28],b[28],muxsel1,s[29]);
  mux8x1 mux281(b[28],b[29],b[29],b[29],b[27],b[27],muxsel1,s[28]);
  mux8x1 mux271(b[27],b[28],b[28],b[28],b[26],b[26],muxsel1,s[27]);
  mux8x1 mux261(b[26],b[27],b[27],b[27],b[25],b[25],muxsel1,s[26]);
  mux8x1 mux251(b[25],b[26],b[26],b[26],b[24],b[24],muxsel1,s[25]);
  mux8x1 mux241(b[24],b[25],b[25],b[25],b[23],b[23],muxsel1,s[24]);
  mux8x1 mux231(b[23],b[24],b[24],b[24],b[22],b[22],muxsel1,s[23]);
  mux8x1 mux221(b[22],b[23],b[23],b[23],b[21],b[21],muxsel1,s[22]);
  mux8x1 mux211(b[21],b[22],b[22],b[22],b[20],b[20],muxsel1,s[21]);
  mux8x1 mux201(b[20],b[21],b[21],b[21],b[19],b[19],muxsel1,s[20]);
  mux8x1 mux191(b[19],b[20],b[20],b[20],b[18],b[18],muxsel1,s[19]);
  mux8x1 mux181(b[18],b[19],b[19],b[19],b[17],b[30],muxsel1,s[18]);
  mux8x1 mux171(b[17],b[18],b[18],b[18],b[16],b[16],muxsel1,s[17]);
  mux8x1 mux161(b[16],b[17],b[17],b[17],b[15],b[15],muxsel1,s[16]);
  mux8x1 mux151(b[15],b[16],b[16],b[16],b[14],b[14],muxsel1,s[15]);
  mux8x1 mux141(b[14],b[15],b[15],b[15],b[13],b[13],muxsel1,s[14]);
  mux8x1 mux131(b[13],b[14],b[14],b[14],b[12],b[12],muxsel1,s[13]);
  mux8x1 mux121(b[12],b[13],b[13],b[13],b[11],b[11],muxsel1,s[12]);
  mux8x1 mux111(b[11],b[12],b[12],b[12],b[10],b[10],muxsel1,s[11]);
  mux8x1 mux101(b[10],b[11],b[11],b[11],b[09],b[09],muxsel1,s[10]);
  mux8x1 mux091(b[09],b[10],b[10],b[10],b[08],b[08],muxsel1,s[9]);
  mux8x1 mux081(b[08],b[09],b[09],b[09],b[07],b[07],muxsel1,s[8]);
  mux8x1 mux071(b[07],b[08],b[08],b[08],b[06],b[06],muxsel1,s[7]);
  mux8x1 mux061(b[06],b[07],b[07],b[07],b[05],b[05],muxsel1,s[6]);
  mux8x1 mux051(b[05],b[06],b[06],b[06],b[04],b[04],muxsel1,s[5]);
  mux8x1 mux041(b[04],b[05],b[05],b[05],b[03],b[03],muxsel1,s[4]);
  mux8x1 mux031(b[03],b[04],b[04],b[04],b[02],b[02],muxsel1,s[3]);
  mux8x1 mux021(b[02],b[03],b[03],b[03],b[01],b[01],muxsel1,s[2]);
  mux8x1 mux011(b[01],b[02],b[02],b[02],b[00],b[00],muxsel1,s[1]);
  mux8x1 mux001(b[00],b[01],b[01],b[01],b[31],b[31],muxsel1,s[0]);
  
  //Second stage
  mux8x1 mux312(s[31],s[31],0,s[1],s[29],s[29],muxsel2,r[31]);
  mux8x1 mux302(s[30],s[31],0,s[0],s[28],s[28],muxsel2,r[30]);
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
  mux8x1 mux012(s[01],s[03],s[03],s[03],0,s[31],muxsel2,r[1]);
  mux8x1 mux002(s[00],s[02],s[02],s[02],0,s[30],muxsel2,r[0]);
  
  //Third stage
  
  mux8x1 mux313(r[31],r[31],0,r[03],r[27],r[27],muxsel3,q[31]);
  mux8x1 mux303(r[30],r[31],0,r[02],r[26],r[26],muxsel3,q[30]);
  mux8x1 mux293(r[29],r[31],0,r[01],r[25],r[25],muxsel3,q[29]);
  mux8x1 mux283(r[28],r[31],0,r[00],r[24],r[24],muxsel3,q[28]);
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
  mux8x1 mux033(r[03],r[07],r[07],r[07],0,r[31],muxsel3,q[3]);
  mux8x1 mux023(r[02],r[06],r[06],r[06],0,r[30],muxsel3,q[2]);
  mux8x1 mux013(r[01],r[05],r[05],r[05],0,r[29],muxsel3,q[1]);
  mux8x1 mux003(r[00],r[04],r[04],r[04],0,r[28],muxsel3,q[0]);
  
   //Fourth stage
  
  mux8x1 mux314(q[31],q[31],0,q[07],q[23],q[23],muxsel4,p[31]);
  mux8x1 mux304(q[30],q[31],0,q[06],q[22],q[22],muxsel4,p[30]);
  mux8x1 mux294(q[29],q[31],0,q[05],q[21],q[21],muxsel4,p[29]);
  mux8x1 mux284(q[28],q[31],0,q[04],q[20],q[20],muxsel4,p[28]);
  mux8x1 mux274(q[27],q[31],0,q[03],q[19],q[19],muxsel4,p[27]);
  mux8x1 mux264(q[26],q[31],0,q[02],q[18],q[18],muxsel4,p[26]);
  mux8x1 mux254(q[25],q[31],0,q[01],q[17],q[17],muxsel4,p[25]);
  mux8x1 mux244(q[24],q[31],0,q[00],q[16],q[16],muxsel4,p[24]);
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
  mux8x1 mux074(q[07],q[15],q[15],q[15],0,q[31],muxsel4,p[7]);
  mux8x1 mux064(q[06],q[14],q[14],q[14],0,q[30],muxsel4,p[6]);
  mux8x1 mux054(q[05],q[13],q[13],q[13],0,q[29],muxsel4,p[5]);
  mux8x1 mux044(q[04],q[12],q[12],q[12],0,q[28],muxsel4,p[4]);
  mux8x1 mux034(q[03],q[11],q[11],q[11],0,q[27],muxsel4,p[3]);
  mux8x1 mux024(q[02],q[10],q[10],q[10],0,q[26],muxsel4,p[2]);
  mux8x1 mux014(q[01],q[09],q[09],q[09],0,q[25],muxsel4,p[1]);
  mux8x1 mux004(q[00],q[08],q[08],q[08],0,q[24],muxsel4,p[0]);
  
  //Fifth stage
  
  mux8x1 mux315(p[31],p[31],0,p[15],p[15],p[15],muxsel5,o[31]);
  mux8x1 mux305(p[30],p[31],0,p[14],p[14],p[14],muxsel5,o[30]);
  mux8x1 mux295(p[29],p[31],0,p[13],p[13],p[13],muxsel5,o[29]);
  mux8x1 mux285(p[28],p[31],0,p[12],p[12],p[12],muxsel5,o[28]);
  mux8x1 mux275(p[27],p[31],0,p[11],p[11],p[11],muxsel5,o[27]);
  mux8x1 mux265(p[26],p[31],0,p[10],p[10],p[10],muxsel5,o[26]);
  mux8x1 mux255(p[25],p[31],0,p[09],p[09],p[09],muxsel5,o[25]);
  mux8x1 mux245(p[24],p[31],0,p[08],p[08],p[08],muxsel5,o[24]);
  mux8x1 mux235(p[23],p[31],0,p[07],p[07],p[07],muxsel5,o[23]);
  mux8x1 mux225(p[22],p[31],0,p[06],p[06],p[06],muxsel5,o[22]);
  mux8x1 mux215(p[21],p[31],0,p[05],p[05],p[05],muxsel5,o[21]);
  mux8x1 mux205(p[20],p[31],0,p[04],p[04],p[04],muxsel5,o[20]);
  mux8x1 mux195(p[19],p[31],0,p[03],p[03],p[03],muxsel5,o[19]);
  mux8x1 mux185(p[18],p[31],0,p[02],p[02],p[02],muxsel5,o[18]);
  mux8x1 mux175(p[17],p[31],0,p[01],p[01],p[01],muxsel5,o[17]);
  mux8x1 mux165(p[16],p[31],0,p[00],p[00],p[00],muxsel5,o[16]);
  mux8x1 mux155(p[15],p[31],p[31],p[31],0,p[31],muxsel5,o[15]);
  mux8x1 mux145(p[14],p[30],p[30],p[30],0,p[30],muxsel5,o[14]);
  mux8x1 mux135(p[13],p[29],p[29],p[29],0,p[29],muxsel5,o[13]);
  mux8x1 mux125(p[12],p[28],p[28],p[28],0,p[28],muxsel5,o[12]);
  mux8x1 mux115(p[11],p[27],p[27],p[27],0,p[27],muxsel5,o[11]);
  mux8x1 mux105(p[10],p[26],p[26],p[26],0,p[26],muxsel5,o[10]);
  mux8x1 mux095(p[09],p[25],p[25],p[25],0,p[25],muxsel5,o[9]);
  mux8x1 mux085(p[08],p[24],p[24],p[24],0,p[24],muxsel5,o[8]);
  mux8x1 mux075(p[07],p[23],p[23],p[23],0,p[23],muxsel5,o[7]);
  mux8x1 mux065(p[06],p[22],p[22],p[22],0,p[22],muxsel5,o[6]);
  mux8x1 mux055(p[05],p[21],p[21],p[21],0,p[21],muxsel5,o[5]);
  mux8x1 mux045(p[04],p[20],p[20],p[20],0,p[20],muxsel5,o[4]);
  mux8x1 mux035(p[03],p[19],p[19],p[19],0,p[19],muxsel5,o[3]);
  mux8x1 mux025(p[02],p[18],p[18],p[18],0,p[18],muxsel5,o[2]);
  mux8x1 mux015(p[01],p[17],p[17],p[17],0,p[17],muxsel5,o[1]);
  mux8x1 mux005(p[00],p[16],p[16],p[16],0,p[16],muxsel5,o[0]);
  

endmodule

