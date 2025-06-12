// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : Roundrobin_u0_h8
// Git hash  : 1ca958c88ee1acae0918d8664950ea9447df20f2



module Roundrobin_u0_h8 (
  output wire [2:0]    bin,
  input  wire          S_0_valid,
  output reg           S_0_ready,
  input  wire          S_1_valid,
  output reg           S_1_ready,
  input  wire          S_2_valid,
  output reg           S_2_ready,
  input  wire          S_3_valid,
  output reg           S_3_ready,
  input  wire          S_4_valid,
  output reg           S_4_ready,
  input  wire          S_5_valid,
  output reg           S_5_ready,
  input  wire          S_6_valid,
  output reg           S_6_ready,
  input  wire          S_7_valid,
  output reg           S_7_ready,
  output wire          M_valid,
  input  wire          M_ready,
  input  wire          clk,
  input  wire          reset
);

  wire       [7:0]    hotHigh_hot;
  wire       [7:0]    hotLow_hot;
  wire       [2:0]    hotHigh_bin;
  wire                hotHigh_zero;
  wire       [2:0]    hotLow_bin;
  wire                hotLow_zero;
  wire       [7:0]    _zz_maskHigh;
  wire       [7:0]    maskHigh;
  reg        [7:0]    maskLow;
  reg        [7:0]    req;
  wire       [7:0]    _zz_1;
  wire                _zz_S_0_ready;
  wire                rdy;
  wire                vld;
  wire       [2:0]    nx;
  reg                 vld_regNextWhen;
  reg        [2:0]    nx_regNextWhen;

  assign _zz_maskHigh = ((~ 8'h0) <<< bin);
  CX_Hot2binLowFirst_b3 hotHigh (
    .hot  (hotHigh_hot[7:0]), //i
    .bin  (hotHigh_bin[2:0]), //o
    .zero (hotHigh_zero    )  //o
  );
  CX_Hot2binLowFirst_b3 hotLow (
    .hot  (hotLow_hot[7:0]), //i
    .bin  (hotLow_bin[2:0]), //o
    .zero (hotLow_zero    )  //o
  );
  assign maskHigh = (_zz_maskHigh <<< 1);
  always @(*) begin
    maskLow = (~ maskHigh);
    maskLow[bin] = (! M_valid);
  end

  always @(*) begin
    req[0] = S_0_valid;
    req[1] = S_1_valid;
    req[2] = S_2_valid;
    req[3] = S_3_valid;
    req[4] = S_4_valid;
    req[5] = S_5_valid;
    req[6] = S_6_valid;
    req[7] = S_7_valid;
  end

  always @(*) begin
    S_0_ready = 1'b0;
    if(_zz_1[0]) begin
      S_0_ready = _zz_S_0_ready;
    end
  end

  always @(*) begin
    S_1_ready = 1'b0;
    if(_zz_1[1]) begin
      S_1_ready = _zz_S_0_ready;
    end
  end

  always @(*) begin
    S_2_ready = 1'b0;
    if(_zz_1[2]) begin
      S_2_ready = _zz_S_0_ready;
    end
  end

  always @(*) begin
    S_3_ready = 1'b0;
    if(_zz_1[3]) begin
      S_3_ready = _zz_S_0_ready;
    end
  end

  always @(*) begin
    S_4_ready = 1'b0;
    if(_zz_1[4]) begin
      S_4_ready = _zz_S_0_ready;
    end
  end

  always @(*) begin
    S_5_ready = 1'b0;
    if(_zz_1[5]) begin
      S_5_ready = _zz_S_0_ready;
    end
  end

  always @(*) begin
    S_6_ready = 1'b0;
    if(_zz_1[6]) begin
      S_6_ready = _zz_S_0_ready;
    end
  end

  always @(*) begin
    S_7_ready = 1'b0;
    if(_zz_1[7]) begin
      S_7_ready = _zz_S_0_ready;
    end
  end

  assign _zz_1 = ({7'd0,1'b1} <<< bin);
  assign _zz_S_0_ready = (M_ready && M_valid);
  assign hotHigh_hot = (req & maskHigh);
  assign hotLow_hot = (req & maskLow);
  assign rdy = ((! M_valid) || M_ready);
  assign vld = ((! hotHigh_zero) || (! hotLow_zero));
  assign nx = (hotHigh_zero ? hotLow_bin : hotHigh_bin);
  assign M_valid = vld_regNextWhen;
  assign bin = nx_regNextWhen;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      vld_regNextWhen <= 1'b0;
    end else begin
      if(rdy) begin
        vld_regNextWhen <= vld;
      end
    end
  end

  always @(posedge clk) begin
    if((rdy && vld)) begin
      nx_regNextWhen <= nx;
    end
  end


endmodule

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

module CX_Hot2binLowFirst_b3 (
  input  wire [7:0]    hot,
  output reg  [2:0]    bin,
  output wire          zero
);


  always @(*) begin
    if((1'b1 == hot[0])) begin
        bin = 3'b000;
    end else if((1'b1 == hot[1])) begin
        bin = 3'b001;
    end else if((1'b1 == hot[2])) begin
        bin = 3'b010;
    end else if((1'b1 == hot[3])) begin
        bin = 3'b011;
    end else if((1'b1 == hot[4])) begin
        bin = 3'b100;
    end else if((1'b1 == hot[5])) begin
        bin = 3'b101;
    end else if((1'b1 == hot[6])) begin
        bin = 3'b110;
    end else if((1'b1 == hot[7])) begin
        bin = 3'b111;
    end else begin
        bin = 3'b000;
    end
  end

  assign zero = (hot == 8'h0);

endmodule
