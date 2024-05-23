`default_nettype none

module FP8_MUL(
  input  [7:0] io_inputA,
  input  [7:0] io_inputB,
  output [7:0] io_output
);
  wire  signA = io_inputA[7]; // @[FP8_MUL.scala 13:20]
  wire [4:0] expA = io_inputA[6:2]; // @[FP8_MUL.scala 14:24]
  wire [1:0] sigA = io_inputA[1:0]; // @[FP8_MUL.scala 15:27]
  wire  signB = io_inputB[7]; // @[FP8_MUL.scala 13:20]
  wire [4:0] expB = io_inputB[6:2]; // @[FP8_MUL.scala 14:24]
  wire [1:0] sigB = io_inputB[1:0]; // @[FP8_MUL.scala 15:27]
  wire  _infFlagA_T = expA == 5'h1f; // @[FP8_MUL.scala 24:25]
  wire  _infFlagA_T_1 = sigA == 2'h0; // @[FP8_MUL.scala 24:48]
  wire  infFlagA = expA == 5'h1f & sigA == 2'h0; // @[FP8_MUL.scala 24:40]
  wire  _infFlagB_T = expB == 5'h1f; // @[FP8_MUL.scala 25:25]
  wire  _infFlagB_T_1 = sigB == 2'h0; // @[FP8_MUL.scala 25:48]
  wire  infFlagB = expB == 5'h1f & sigB == 2'h0; // @[FP8_MUL.scala 25:40]
  wire  _zeroFlagA_T = expA == 5'h0; // @[FP8_MUL.scala 28:26]
  wire  zeroFlagA = expA == 5'h0 & _infFlagA_T_1; // @[FP8_MUL.scala 28:41]
  wire  _zeroFlagB_T = expB == 5'h0; // @[FP8_MUL.scala 29:26]
  wire  zeroFlagB = expB == 5'h0 & _infFlagB_T_1; // @[FP8_MUL.scala 29:41]
  wire  _nanFlagA_T_1 = sigA != 2'h0; // @[FP8_MUL.scala 32:48]
  wire  nanFlagA = _infFlagA_T & sigA != 2'h0; // @[FP8_MUL.scala 32:40]
  wire  _nanFlagB_T_1 = sigB != 2'h0; // @[FP8_MUL.scala 33:48]
  wire  nanFlagB = _infFlagB_T & sigB != 2'h0; // @[FP8_MUL.scala 33:40]
  wire  subFlagA = _zeroFlagA_T & _nanFlagA_T_1; // @[FP8_MUL.scala 36:40]
  wire  subFlagB = _zeroFlagB_T & _nanFlagB_T_1; // @[FP8_MUL.scala 37:40]
  wire [7:0] _io_output_T = infFlagA ? io_inputA : io_inputB; // @[FP8_MUL.scala 55:23]
  wire [7:0] _GEN_0 = infFlagA & infFlagB & signA != signB ? 8'h7f : _io_output_T; // @[FP8_MUL.scala 52:53 53:17 55:17]
  wire [5:0] _ovrChk_6_T = expA + expB; // @[FP8_MUL.scala 61:22]
  wire  _sigMul_6_T = ~subFlagA; // @[FP8_MUL.scala 62:21]
  wire [2:0] _sigMul_6_T_1 = {_sigMul_6_T,sigA}; // @[Cat.scala 33:92]
  wire  _sigMul_6_T_2 = ~subFlagB; // @[FP8_MUL.scala 62:43]
  wire [2:0] _sigMul_6_T_3 = {_sigMul_6_T_2,sigB}; // @[Cat.scala 33:92]
  wire [5:0] _sigMul_6_T_4 = _sigMul_6_T_1 * _sigMul_6_T_3; // @[FP8_MUL.scala 62:37]
  wire [5:0] _GEN_4 = nanFlagA | nanFlagB ? 6'h0 : _ovrChk_6_T; // @[FP8_MUL.scala 42:14 57:35 61:14]
  wire [5:0] _GEN_7 = infFlagA | infFlagB ? 6'h0 : _GEN_4; // @[FP8_MUL.scala 42:14 50:35]
  wire [5:0] _GEN_10 = zeroFlagA | zeroFlagB ? 6'h0 : _GEN_7; // @[FP8_MUL.scala 42:14 48:37]
  wire [5:0] ovrChk_6 = zeroFlagA & zeroFlagB ? 6'h0 : _GEN_10; // @[FP8_MUL.scala 42:14 45:32]
  wire  _io_output_T_1 = signA ^ signB; // @[FP8_MUL.scala 64:30]
  wire [7:0] _io_output_T_2 = {_io_output_T_1,7'h7c}; // @[Cat.scala 33:92]
  wire [5:0] _io_output_T_5 = ovrChk_6 - 6'hf; // @[FP8_MUL.scala 69:50]
  wire [5:0] _GEN_5 = nanFlagA | nanFlagB ? 6'h0 : _sigMul_6_T_4; // @[FP8_MUL.scala 43:14 57:35 62:14]
  wire [5:0] _GEN_8 = infFlagA | infFlagB ? 6'h0 : _GEN_5; // @[FP8_MUL.scala 43:14 50:35]
  wire [5:0] _GEN_11 = zeroFlagA | zeroFlagB ? 6'h0 : _GEN_8; // @[FP8_MUL.scala 43:14 48:37]
  wire [5:0] sigMul_6 = zeroFlagA & zeroFlagB ? 6'h0 : _GEN_11; // @[FP8_MUL.scala 43:14 45:32]
  wire [4:0] _GEN_15 = {{4'd0}, sigMul_6[5]}; // @[FP8_MUL.scala 69:63]
  wire [4:0] _io_output_T_9 = _io_output_T_5[4:0] + _GEN_15; // @[FP8_MUL.scala 69:63]
  wire [5:0] _io_output_T_11 = sigMul_6 >> sigMul_6[5]; // @[FP8_MUL.scala 69:89]
  wire [7:0] _io_output_T_13 = {_io_output_T_1,_io_output_T_9,_io_output_T_11[3:2]}; // @[Cat.scala 33:92]
  wire [7:0] _GEN_1 = ovrChk_6 < 6'hf ? 8'h0 : _io_output_T_13; // @[FP8_MUL.scala 65:32 66:17 69:17]
  wire [7:0] _GEN_2 = ovrChk_6 > 6'h2d ? _io_output_T_2 : _GEN_1; // @[FP8_MUL.scala 63:26 64:17]
  wire [7:0] _GEN_3 = nanFlagA | nanFlagB ? 8'h7f : _GEN_2; // @[FP8_MUL.scala 57:35 58:15]
  wire [7:0] _GEN_6 = infFlagA | infFlagB ? _GEN_0 : _GEN_3; // @[FP8_MUL.scala 50:35]
  wire [7:0] _GEN_9 = zeroFlagA | zeroFlagB ? 8'h0 : _GEN_6; // @[FP8_MUL.scala 48:37 49:15]
  assign io_output = zeroFlagA & zeroFlagB ? 8'h0 : _GEN_9; // @[FP8_MUL.scala 45:32 47:15]
endmodule

module FP8_ADD(
  input  [7:0] io_inputA,
  input  [7:0] io_inputB,
  output [7:0] io_output
);
  wire  signA = io_inputA[7]; // @[FP8_ADD.scala 13:18]
  wire [4:0] expA = io_inputA[6:2]; // @[FP8_ADD.scala 14:22]
  wire [1:0] sigA = io_inputA[1:0]; // @[FP8_ADD.scala 15:25]
  wire  signB = io_inputB[7]; // @[FP8_ADD.scala 13:18]
  wire [4:0] expB = io_inputB[6:2]; // @[FP8_ADD.scala 14:22]
  wire [1:0] sigB = io_inputB[1:0]; // @[FP8_ADD.scala 15:25]
  wire  _infFlagA_T = expA == 5'h1f; // @[FP8_ADD.scala 24:23]
  wire  _infFlagA_T_1 = sigA == 2'h0; // @[FP8_ADD.scala 24:46]
  wire  infFlagA = expA == 5'h1f & sigA == 2'h0; // @[FP8_ADD.scala 24:38]
  wire  _infFlagB_T = expB == 5'h1f; // @[FP8_ADD.scala 25:23]
  wire  _infFlagB_T_1 = sigB == 2'h0; // @[FP8_ADD.scala 25:46]
  wire  infFlagB = expB == 5'h1f & sigB == 2'h0; // @[FP8_ADD.scala 25:38]
  wire  _zeroFlagA_T = expA == 5'h0; // @[FP8_ADD.scala 28:24]
  wire  zeroFlagA = expA == 5'h0 & _infFlagA_T_1; // @[FP8_ADD.scala 28:39]
  wire  _zeroFlagB_T = expB == 5'h0; // @[FP8_ADD.scala 29:24]
  wire  zeroFlagB = expB == 5'h0 & _infFlagB_T_1; // @[FP8_ADD.scala 29:39]
  wire  _nanFlagA_T_1 = sigA != 2'h0; // @[FP8_ADD.scala 32:46]
  wire  nanFlagA = _infFlagA_T & sigA != 2'h0; // @[FP8_ADD.scala 32:38]
  wire  _nanFlagB_T_1 = sigB != 2'h0; // @[FP8_ADD.scala 33:46]
  wire  nanFlagB = _infFlagB_T & sigB != 2'h0; // @[FP8_ADD.scala 33:38]
  wire  subFlagA = _zeroFlagA_T & _nanFlagA_T_1; // @[FP8_ADD.scala 36:38]
  wire  subFlagB = _zeroFlagB_T & _nanFlagB_T_1; // @[FP8_ADD.scala 37:38]
  wire [7:0] _io_output_T = zeroFlagA ? io_inputB : io_inputA; // @[FP8_ADD.scala 56:21]
  wire  _T_4 = signA != signB; // @[FP8_ADD.scala 59:42]
  wire [7:0] _io_output_T_1 = infFlagA ? io_inputA : io_inputB; // @[FP8_ADD.scala 62:23]
  wire [7:0] _GEN_0 = infFlagA & infFlagB & signA != signB ? 8'h7f : _io_output_T_1; // @[FP8_ADD.scala 59:53 60:17 62:17]
  wire  _T_8 = sigA > sigB; // @[FP8_ADD.scala 71:17]
  wire [2:0] _ovrChk_a_n_T = {1'h0,sigA}; // @[Cat.scala 33:92]
  wire [2:0] _ovrChk_a_n_T_1 = {1'h0,sigB}; // @[Cat.scala 33:92]
  wire [3:0] _ovrChk_a_n_T_2 = _ovrChk_a_n_T + _ovrChk_a_n_T_1; // @[FP8_ADD.scala 72:38]
  wire [2:0] _ovrChk_s_n_T_3 = _ovrChk_a_n_T - _ovrChk_a_n_T_1; // @[FP8_ADD.scala 73:38]
  wire  _io_output_T_2 = ~signA; // @[FP8_ADD.scala 74:32]
  wire  _io_output_T_3 = ~signB; // @[FP8_ADD.scala 74:62]
  wire  _T_9 = sigB > sigA; // @[FP8_ADD.scala 75:23]
  wire [3:0] _ovrChk_a_n_T_5 = _ovrChk_a_n_T_1 + _ovrChk_a_n_T; // @[FP8_ADD.scala 76:38]
  wire [3:0] _GEN_1 = sigB > sigA ? _ovrChk_a_n_T_5 : _ovrChk_a_n_T_5; // @[FP8_ADD.scala 75:30 76:20 80:20]
  wire [3:0] _GEN_4 = sigA > sigB ? _ovrChk_a_n_T_2 : _GEN_1; // @[FP8_ADD.scala 71:24 72:20]
  wire [3:0] _GEN_21 = subFlagA & subFlagB ? _GEN_4 : 4'h0; // @[FP8_ADD.scala 49:14 68:31]
  wire [3:0] _GEN_27 = nanFlagA | nanFlagB ? 4'h0 : _GEN_21; // @[FP8_ADD.scala 49:14 64:35]
  wire [3:0] _GEN_32 = infFlagA | infFlagB ? 4'h0 : _GEN_27; // @[FP8_ADD.scala 49:14 57:35]
  wire [3:0] _GEN_37 = zeroFlagA | zeroFlagB ? 4'h0 : _GEN_32; // @[FP8_ADD.scala 49:14 55:37]
  wire [3:0] _GEN_42 = zeroFlagA & zeroFlagB ? 4'h0 : _GEN_37; // @[FP8_ADD.scala 49:14 52:32]
  wire [2:0] ovrChk_a_n = _GEN_42[2:0]; // @[FP8_ADD.scala 47:24]
  wire [4:0] _GEN_46 = {{4'd0}, ovrChk_a_n[2]}; // @[FP8_ADD.scala 74:80]
  wire [4:0] _io_output_T_6 = expA + _GEN_46; // @[FP8_ADD.scala 74:80]
  wire [6:0] _io_output_T_8 = {_io_output_T_6,ovrChk_a_n[1:0]}; // @[Cat.scala 33:92]
  wire [2:0] _ovrChk_s_n_T_7 = _ovrChk_a_n_T_1 - _ovrChk_a_n_T; // @[FP8_ADD.scala 77:38]
  wire [2:0] _GEN_2 = sigB > sigA ? _ovrChk_s_n_T_7 : 3'h0; // @[FP8_ADD.scala 50:14 75:30 77:20]
  wire [2:0] _GEN_5 = sigA > sigB ? _ovrChk_s_n_T_3 : _GEN_2; // @[FP8_ADD.scala 71:24 73:20]
  wire [2:0] _GEN_22 = subFlagA & subFlagB ? _GEN_5 : 3'h0; // @[FP8_ADD.scala 50:14 68:31]
  wire [2:0] _GEN_28 = nanFlagA | nanFlagB ? 3'h0 : _GEN_22; // @[FP8_ADD.scala 50:14 64:35]
  wire [2:0] _GEN_33 = infFlagA | infFlagB ? 3'h0 : _GEN_28; // @[FP8_ADD.scala 50:14 57:35]
  wire [2:0] _GEN_38 = zeroFlagA | zeroFlagB ? 3'h0 : _GEN_33; // @[FP8_ADD.scala 50:14 55:37]
  wire [2:0] ovrChk_s_n = zeroFlagA & zeroFlagB ? 3'h0 : _GEN_38; // @[FP8_ADD.scala 50:14 52:32]
  wire [4:0] _GEN_47 = {{4'd0}, ovrChk_s_n[2]}; // @[FP8_ADD.scala 74:124]
  wire [4:0] _io_output_T_11 = expA + _GEN_47; // @[FP8_ADD.scala 74:124]
  wire [6:0] _io_output_T_13 = {_io_output_T_11,ovrChk_s_n[1:0]}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_14 = ~signB ? _io_output_T_8 : _io_output_T_13; // @[FP8_ADD.scala 74:55]
  wire [7:0] _io_output_T_15 = {signA,_io_output_T_14}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_27 = ~signB ? _io_output_T_13 : _io_output_T_8; // @[FP8_ADD.scala 74:175]
  wire [7:0] _io_output_T_28 = {signA,_io_output_T_27}; // @[Cat.scala 33:92]
  wire [7:0] _io_output_T_29 = ~signA ? _io_output_T_15 : _io_output_T_28; // @[FP8_ADD.scala 74:25]
  wire [4:0] _io_output_T_34 = expB + _GEN_46; // @[FP8_ADD.scala 78:80]
  wire [6:0] _io_output_T_36 = {_io_output_T_34,ovrChk_a_n[1:0]}; // @[Cat.scala 33:92]
  wire [4:0] _io_output_T_39 = expB + _GEN_47; // @[FP8_ADD.scala 78:124]
  wire [6:0] _io_output_T_41 = {_io_output_T_39,ovrChk_s_n[1:0]}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_42 = _io_output_T_2 ? _io_output_T_36 : _io_output_T_41; // @[FP8_ADD.scala 78:55]
  wire [7:0] _io_output_T_43 = {signB,_io_output_T_42}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_55 = _io_output_T_2 ? _io_output_T_41 : _io_output_T_36; // @[FP8_ADD.scala 78:175]
  wire [7:0] _io_output_T_56 = {signB,_io_output_T_55}; // @[Cat.scala 33:92]
  wire [7:0] _io_output_T_57 = _io_output_T_3 ? _io_output_T_43 : _io_output_T_56; // @[FP8_ADD.scala 78:25]
  wire [7:0] _io_output_T_63 = {signA,_io_output_T_6,ovrChk_a_n[1:0]}; // @[Cat.scala 33:92]
  wire [7:0] _io_output_T_64 = signB != signA ? 8'h0 : _io_output_T_63; // @[FP8_ADD.scala 82:25]
  wire [7:0] _GEN_3 = sigB > sigA ? _io_output_T_57 : _io_output_T_64; // @[FP8_ADD.scala 75:30 78:19 82:19]
  wire [7:0] _GEN_6 = sigA > sigB ? _io_output_T_29 : _GEN_3; // @[FP8_ADD.scala 71:24 74:19]
  wire [2:0] _ovrChk_a_T = {1'h1,sigA}; // @[Cat.scala 33:92]
  wire [2:0] _ovrChk_a_T_1 = {1'h1,sigB}; // @[Cat.scala 33:92]
  wire [4:0] _ovrChk_a_T_3 = expA - expB; // @[FP8_ADD.scala 96:64]
  wire [2:0] _ovrChk_a_T_4 = _ovrChk_a_T_1 >> _ovrChk_a_T_3; // @[FP8_ADD.scala 96:55]
  wire [3:0] _ovrChk_a_T_5 = _ovrChk_a_T + _ovrChk_a_T_4; // @[FP8_ADD.scala 96:36]
  wire [2:0] _ovrChk_s_T_6 = _ovrChk_a_T - _ovrChk_a_T_4; // @[FP8_ADD.scala 97:36]
  wire [4:0] _ovrChk_a_T_9 = expB - expA; // @[FP8_ADD.scala 102:64]
  wire [2:0] _ovrChk_a_T_10 = _ovrChk_a_T >> _ovrChk_a_T_9; // @[FP8_ADD.scala 102:55]
  wire [3:0] _ovrChk_a_T_11 = _ovrChk_a_T_1 + _ovrChk_a_T_10; // @[FP8_ADD.scala 102:36]
  wire [3:0] _GEN_9 = expB > expA ? _ovrChk_a_T_11 : _ovrChk_a_T_11; // @[FP8_ADD.scala 100:30 102:18 107:18]
  wire [3:0] _GEN_12 = expA > expB ? _ovrChk_a_T_5 : _GEN_9; // @[FP8_ADD.scala 94:24 96:18]
  wire [2:0] _ovrChk_a_T_22 = _ovrChk_a_n_T_1 >> _ovrChk_a_T_3; // @[FP8_ADD.scala 127:55]
  wire [3:0] _ovrChk_a_T_23 = _ovrChk_a_T + _ovrChk_a_T_22; // @[FP8_ADD.scala 127:36]
  wire [2:0] _ovrChk_a_T_28 = _ovrChk_a_n_T >> _ovrChk_a_T_9; // @[FP8_ADD.scala 131:55]
  wire [3:0] _ovrChk_a_T_29 = _ovrChk_a_T_1 + _ovrChk_a_T_28; // @[FP8_ADD.scala 131:36]
  wire [3:0] _GEN_15 = subFlagB ? _ovrChk_a_T_23 : _ovrChk_a_T_29; // @[FP8_ADD.scala 126:21 127:18 131:18]
  wire [3:0] _GEN_18 = ~subFlagA & ~subFlagB ? _GEN_12 : _GEN_15; // @[FP8_ADD.scala 86:39]
  wire [3:0] _GEN_24 = subFlagA & subFlagB ? 4'h0 : _GEN_18; // @[FP8_ADD.scala 43:12 68:31]
  wire [3:0] _GEN_29 = nanFlagA | nanFlagB ? 4'h0 : _GEN_24; // @[FP8_ADD.scala 43:12 64:35]
  wire [3:0] _GEN_34 = infFlagA | infFlagB ? 4'h0 : _GEN_29; // @[FP8_ADD.scala 43:12 57:35]
  wire [3:0] _GEN_39 = zeroFlagA | zeroFlagB ? 4'h0 : _GEN_34; // @[FP8_ADD.scala 43:12 55:37]
  wire [3:0] ovrChk_a = zeroFlagA & zeroFlagB ? 4'h0 : _GEN_39; // @[FP8_ADD.scala 43:12 52:32]
  wire [4:0] _GEN_55 = {{4'd0}, ovrChk_a[3]}; // @[FP8_ADD.scala 98:80]
  wire [4:0] _io_output_T_69 = expA + _GEN_55; // @[FP8_ADD.scala 98:80]
  wire [3:0] _io_output_T_71 = ovrChk_a >> ovrChk_a[3]; // @[FP8_ADD.scala 98:105]
  wire [6:0] _io_output_T_73 = {_io_output_T_69,_io_output_T_71[1:0]}; // @[Cat.scala 33:92]
  wire [2:0] _ovrChk_s_T_13 = _ovrChk_a_T_1 - _ovrChk_a_T_10; // @[FP8_ADD.scala 103:36]
  wire [2:0] _GEN_10 = expB > expA ? _ovrChk_s_T_13 : _ovrChk_s_T_13; // @[FP8_ADD.scala 100:30 103:18 108:18]
  wire [2:0] _GEN_13 = expA > expB ? _ovrChk_s_T_6 : _GEN_10; // @[FP8_ADD.scala 94:24 97:18]
  wire [2:0] _ovrChk_s_T_27 = _ovrChk_a_T - _ovrChk_a_T_22; // @[FP8_ADD.scala 128:36]
  wire [2:0] _ovrChk_s_T_34 = _ovrChk_a_T_1 - _ovrChk_a_T_28; // @[FP8_ADD.scala 132:36]
  wire [2:0] _GEN_16 = subFlagB ? _ovrChk_s_T_27 : _ovrChk_s_T_34; // @[FP8_ADD.scala 126:21 128:18 132:18]
  wire [2:0] _GEN_19 = ~subFlagA & ~subFlagB ? _GEN_13 : _GEN_16; // @[FP8_ADD.scala 86:39]
  wire [2:0] _GEN_25 = subFlagA & subFlagB ? 3'h0 : _GEN_19; // @[FP8_ADD.scala 44:12 68:31]
  wire [2:0] _GEN_30 = nanFlagA | nanFlagB ? 3'h0 : _GEN_25; // @[FP8_ADD.scala 44:12 64:35]
  wire [2:0] _GEN_35 = infFlagA | infFlagB ? 3'h0 : _GEN_30; // @[FP8_ADD.scala 44:12 57:35]
  wire [2:0] _GEN_40 = zeroFlagA | zeroFlagB ? 3'h0 : _GEN_35; // @[FP8_ADD.scala 44:12 55:37]
  wire [2:0] _GEN_45 = zeroFlagA & zeroFlagB ? 3'h0 : _GEN_40; // @[FP8_ADD.scala 44:12 52:32]
  wire [3:0] ovrChk_s = {{1'd0}, _GEN_45}; // @[FP8_ADD.scala 41:22]
  wire [4:0] _GEN_56 = {{4'd0}, ovrChk_s[3]}; // @[FP8_ADD.scala 98:137]
  wire [4:0] _io_output_T_76 = expA + _GEN_56; // @[FP8_ADD.scala 98:137]
  wire [3:0] _io_output_T_78 = ovrChk_s >> ovrChk_s[3]; // @[FP8_ADD.scala 98:162]
  wire [6:0] _io_output_T_80 = {_io_output_T_76,_io_output_T_78[1:0]}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_81 = _io_output_T_3 ? _io_output_T_73 : _io_output_T_80; // @[FP8_ADD.scala 98:55]
  wire [7:0] _io_output_T_82 = {signA,_io_output_T_81}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_98 = _io_output_T_3 ? _io_output_T_80 : _io_output_T_73; // @[FP8_ADD.scala 98:201]
  wire [7:0] _io_output_T_99 = {signA,_io_output_T_98}; // @[Cat.scala 33:92]
  wire [7:0] _io_output_T_100 = _io_output_T_2 ? _io_output_T_82 : _io_output_T_99; // @[FP8_ADD.scala 98:25]
  wire [4:0] _io_output_T_105 = expB + _GEN_55; // @[FP8_ADD.scala 104:80]
  wire [6:0] _io_output_T_109 = {_io_output_T_105,_io_output_T_71[1:0]}; // @[Cat.scala 33:92]
  wire [4:0] _io_output_T_112 = expB + _GEN_56; // @[FP8_ADD.scala 104:137]
  wire [6:0] _io_output_T_116 = {_io_output_T_112,_io_output_T_78[1:0]}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_117 = _io_output_T_2 ? _io_output_T_109 : _io_output_T_116; // @[FP8_ADD.scala 104:55]
  wire [7:0] _io_output_T_118 = {signB,_io_output_T_117}; // @[Cat.scala 33:92]
  wire [6:0] _io_output_T_134 = _io_output_T_2 ? _io_output_T_116 : _io_output_T_109; // @[FP8_ADD.scala 104:201]
  wire [7:0] _io_output_T_135 = {signB,_io_output_T_134}; // @[Cat.scala 33:92]
  wire [7:0] _io_output_T_136 = _io_output_T_3 ? _io_output_T_118 : _io_output_T_135; // @[FP8_ADD.scala 104:25]
  wire [7:0] _io_output_T_216 = {signA,_io_output_T_69,_io_output_T_71[1:0]}; // @[Cat.scala 33:92]
  wire [7:0] _io_output_T_217 = _T_4 ? 8'h0 : _io_output_T_216; // @[FP8_ADD.scala 117:27]
  wire [7:0] _GEN_7 = _T_9 ? _io_output_T_136 : _io_output_T_217; // @[FP8_ADD.scala 113:32 114:21 117:21]
  wire [7:0] _GEN_8 = _T_8 ? _io_output_T_100 : _GEN_7; // @[FP8_ADD.scala 110:26 111:21]
  wire [7:0] _GEN_11 = expB > expA ? _io_output_T_136 : _GEN_8; // @[FP8_ADD.scala 100:30 104:19]
  wire [7:0] _GEN_14 = expA > expB ? _io_output_T_100 : _GEN_11; // @[FP8_ADD.scala 94:24 98:19]
  wire [7:0] _GEN_17 = subFlagB ? _io_output_T_100 : _io_output_T_136; // @[FP8_ADD.scala 126:21 129:19 133:19]
  wire [7:0] _GEN_20 = ~subFlagA & ~subFlagB ? _GEN_14 : _GEN_17; // @[FP8_ADD.scala 86:39]
  wire [7:0] _GEN_23 = subFlagA & subFlagB ? _GEN_6 : _GEN_20; // @[FP8_ADD.scala 68:31]
  wire [7:0] _GEN_26 = nanFlagA | nanFlagB ? 8'h7f : _GEN_23; // @[FP8_ADD.scala 64:35 65:15]
  wire [7:0] _GEN_31 = infFlagA | infFlagB ? _GEN_0 : _GEN_26; // @[FP8_ADD.scala 57:35]
  wire [7:0] _GEN_36 = zeroFlagA | zeroFlagB ? _io_output_T : _GEN_31; // @[FP8_ADD.scala 55:37 56:15]
  assign io_output = zeroFlagA & zeroFlagB ? 8'h0 : _GEN_36; // @[FP8_ADD.scala 52:32 54:15]
endmodule


module tt_um_fp_mac(
  input        clk,   	// clock
  input        rst_n, 	// reset_n - low to reset
  input  [7:0] ui_in, 	// io_wgt
  input  [7:0] uio_in, 	// io_ifm
  output [7:0] uo_out,
  output [7:0] uio_out,
  output [7:0] uio_oe, 	// IOs: Enable path (active high: 0=input, 1=output)
  input        ena     // always 1 when the design is powered, so you can ignore it
  //output       io_valid
);
// `ifdef RANDOMIZE_REG_INIT
//   reg [31:0] _RAND_0;
//   reg [31:0] _RAND_1;
// `endif // RANDOMIZE_REG_INIT
  wire [7:0] multiplier_io_inputA; // @[MAC_TOP.scala 13:26]
  wire [7:0] multiplier_io_inputB; // @[MAC_TOP.scala 13:26]
  wire [7:0] multiplier_io_output; // @[MAC_TOP.scala 13:26]
  wire [7:0] adder_io_inputA; // @[MAC_TOP.scala 14:21]
  wire [7:0] adder_io_inputB; // @[MAC_TOP.scala 14:21]
  wire [7:0] adder_io_output; // @[MAC_TOP.scala 14:21]
  reg [7:0] resBuff; // @[MAC_TOP.scala 56:24]
  reg [1:0] count; // @[MAC_TOP.scala 57:22]
  wire  _nextval_T = count < 2'h3; // @[MAC_TOP.scala 58:27]
  wire [1:0] _count_T_2 = count + 2'h1; // @[MAC_TOP.scala 64:42]
  FP8_MUL multiplier ( // @[MAC_TOP.scala 13:26]
    .io_inputA(multiplier_io_inputA),
    .io_inputB(multiplier_io_inputB),
    .io_output(multiplier_io_output)
  );
  FP8_ADD adder ( // @[MAC_TOP.scala 14:21]
    .io_inputA(adder_io_inputA),
    .io_inputB(adder_io_inputB),
    .io_output(adder_io_output)
  );

  assign uio_out = 0;
  assign uio_oe  = 0;

  assign uo_out = resBuff; // @[MAC_TOP.scala 66:13]
  //assign io_valid = count == 2'h3; // @[MAC_TOP.scala 65:21]
  assign multiplier_io_inputA = ui_in; // @[MAC_TOP.scala 51:26]
  assign multiplier_io_inputB = uio_in; // @[MAC_TOP.scala 52:26]
  assign adder_io_inputA = multiplier_io_output; // @[MAC_TOP.scala 61:19]
  assign adder_io_inputB = resBuff; // @[MAC_TOP.scala 62:19]
  always @(posedge clk) begin
    if (!rst_n) begin // @[MAC_TOP.scala 56:24]
      resBuff <= 8'h0; // @[MAC_TOP.scala 56:24]
    end else if (_nextval_T) begin // @[MAC_TOP.scala 59:17]
      if (count < 2'h3) begin // @[MAC_TOP.scala 58:20]
        resBuff <= adder_io_output;
      end else begin
        resBuff <= 8'h0;
      end
    end else begin
      resBuff <= 8'h0;
    end
    if (!rst_n) begin // @[MAC_TOP.scala 57:22]
      count <= 2'h0; // @[MAC_TOP.scala 57:22]
    end else if (count == 2'h3) begin // @[MAC_TOP.scala 64:15]
      count <= 2'h0;
    end else begin
      count <= _count_T_2;
    end
  end
// Register and memory initialization
// `ifdef RANDOMIZE_GARBAGE_ASSIGN
// `define RANDOMIZE
// `endif
// `ifdef RANDOMIZE_INVALID_ASSIGN
// `define RANDOMIZE
// `endif
// `ifdef RANDOMIZE_REG_INIT
// `define RANDOMIZE
// `endif
// `ifdef RANDOMIZE_MEM_INIT
// `define RANDOMIZE
// `endif
// `ifndef RANDOM
// `define RANDOM $random
// `endif
// `ifdef RANDOMIZE_MEM_INIT
//   integer initvar;
// `endif
// `ifndef SYNTHESIS
// `ifdef FIRRTL_BEFORE_INITIAL
// `FIRRTL_BEFORE_INITIAL
// `endif
// initial begin
//   `ifdef RANDOMIZE
//     `ifdef INIT_RANDOM
//       `INIT_RANDOM
//     `endif
//     `ifndef VERILATOR
//       `ifdef RANDOMIZE_DELAY
//         #`RANDOMIZE_DELAY begin end
//       `else
//         #0.002 begin end
//       `endif
//     `endif
// `ifdef RANDOMIZE_REG_INIT
//   _RAND_0 = {1{`RANDOM}};
//   resBuff = _RAND_0[7:0];
//   _RAND_1 = {1{`RANDOM}};
//   count = _RAND_1[1:0];
// `endif // RANDOMIZE_REG_INIT
//   `endif // RANDOMIZE
// end // initial
// `ifdef FIRRTL_AFTER_INITIAL
// `FIRRTL_AFTER_INITIAL
// `endif
// `endif // SYNTHESIS
endmodule
