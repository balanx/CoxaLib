// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : RoundStrict_u1_h4
// Git hash  : 1ca958c88ee1acae0918d8664950ea9447df20f2



module RoundStrict_u1_h4 (
  output wire [1:0]    bin,
  input  wire          S_0_valid,
  output reg           S_0_ready,
  input  wire [0:0]    S_0_payload,
  input  wire          S_1_valid,
  output reg           S_1_ready,
  input  wire [0:0]    S_1_payload,
  input  wire          S_2_valid,
  output reg           S_2_ready,
  input  wire [0:0]    S_2_payload,
  input  wire          S_3_valid,
  output reg           S_3_ready,
  input  wire [0:0]    S_3_payload,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [0:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  reg        [3:0]    s_hot;
  wire       [1:0]    s_bin;
  wire                s_zero;
  reg                 _zz__zz_1;
  reg                 _zz__zz_M_valid_1;
  reg        [0:0]    _zz__zz_M_payload;
  wire                _zz_1;
  wire       [3:0]    _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                _zz_M_valid;
  wire                _zz_S_0_ready;
  reg                 _zz_M_valid_1;
  reg        [0:0]    _zz_M_payload;
  reg        [1:0]    bin_regNext;

  CX_Hot2binLowFirst_b2 s (
    .hot  (s_hot[3:0]), //i
    .bin  (s_bin[1:0]), //o
    .zero (s_zero    )  //o
  );
  always @(*) begin
    case(s_bin)
      2'b00 : begin
        _zz__zz_1 = S_0_ready;
        _zz__zz_M_valid_1 = S_0_valid;
        _zz__zz_M_payload = S_0_payload;
      end
      2'b01 : begin
        _zz__zz_1 = S_1_ready;
        _zz__zz_M_valid_1 = S_1_valid;
        _zz__zz_M_payload = S_1_payload;
      end
      2'b10 : begin
        _zz__zz_1 = S_2_ready;
        _zz__zz_M_valid_1 = S_2_valid;
        _zz__zz_M_payload = S_2_payload;
      end
      default : begin
        _zz__zz_1 = S_3_ready;
        _zz__zz_M_valid_1 = S_3_valid;
        _zz__zz_M_payload = S_3_payload;
      end
    endcase
  end

  always @(*) begin
    s_hot[0] = S_0_valid;
    s_hot[1] = S_1_valid;
    s_hot[2] = S_2_valid;
    s_hot[3] = S_3_valid;
  end

  always @(*) begin
    S_0_ready = 1'b0;
    if(_zz_3) begin
      S_0_ready = _zz_S_0_ready;
    end
    if((! _zz_M_valid)) begin
      if(_zz_3) begin
        S_0_ready = 1'b1;
      end
    end
  end

  always @(*) begin
    S_1_ready = 1'b0;
    if(_zz_4) begin
      S_1_ready = _zz_S_0_ready;
    end
    if((! _zz_M_valid)) begin
      if(_zz_4) begin
        S_1_ready = 1'b1;
      end
    end
  end

  always @(*) begin
    S_2_ready = 1'b0;
    if(_zz_5) begin
      S_2_ready = _zz_S_0_ready;
    end
    if((! _zz_M_valid)) begin
      if(_zz_5) begin
        S_2_ready = 1'b1;
      end
    end
  end

  always @(*) begin
    S_3_ready = 1'b0;
    if(_zz_6) begin
      S_3_ready = _zz_S_0_ready;
    end
    if((! _zz_M_valid)) begin
      if(_zz_6) begin
        S_3_ready = 1'b1;
      end
    end
  end

  assign _zz_1 = _zz__zz_1;
  assign _zz_2 = ({3'd0,1'b1} <<< s_bin);
  assign _zz_3 = _zz_2[0];
  assign _zz_4 = _zz_2[1];
  assign _zz_5 = _zz_2[2];
  assign _zz_6 = _zz_2[3];
  assign _zz_M_valid = _zz_M_valid_1;
  assign M_valid = _zz_M_valid;
  assign _zz_S_0_ready = M_ready;
  assign M_payload = _zz_M_payload;
  assign bin = bin_regNext;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_M_valid_1 <= 1'b0;
      bin_regNext <= 2'b00;
    end else begin
      if(_zz_1) begin
        _zz_M_valid_1 <= _zz__zz_M_valid_1;
      end
      bin_regNext <= s_bin;
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      _zz_M_payload <= _zz__zz_M_payload;
    end
  end


endmodule

module CX_Hot2binLowFirst_b2 (
  input  wire [3:0]    hot,
  output reg  [1:0]    bin,
  output wire          zero
);


  always @(*) begin
    if((1'b1 == hot[0])) begin
        bin = 2'b00;
    end else if((1'b1 == hot[1])) begin
        bin = 2'b01;
    end else if((1'b1 == hot[2])) begin
        bin = 2'b10;
    end else if((1'b1 == hot[3])) begin
        bin = 2'b11;
    end else begin
        bin = 2'b00;
    end
  end

  assign zero = (hot == 4'b0000);

endmodule
