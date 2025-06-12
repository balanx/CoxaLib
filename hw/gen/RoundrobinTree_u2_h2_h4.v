// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : RoundrobinTree_u2_h2_h4
// Git hash  : 1ca958c88ee1acae0918d8664950ea9447df20f2



module RoundrobinTree_u2_h2_h4 (
  output wire [2:0]    bin,
  input  wire          S_0_valid,
  output wire          S_0_ready,
  input  wire [1:0]    S_0_payload,
  input  wire          S_1_valid,
  output wire          S_1_ready,
  input  wire [1:0]    S_1_payload,
  input  wire          S_2_valid,
  output wire          S_2_ready,
  input  wire [1:0]    S_2_payload,
  input  wire          S_3_valid,
  output wire          S_3_ready,
  input  wire [1:0]    S_3_payload,
  input  wire          S_4_valid,
  output wire          S_4_ready,
  input  wire [1:0]    S_4_payload,
  input  wire          S_5_valid,
  output wire          S_5_ready,
  input  wire [1:0]    S_5_payload,
  input  wire          S_6_valid,
  output wire          S_6_ready,
  input  wire [1:0]    S_6_payload,
  input  wire          S_7_valid,
  output wire          S_7_ready,
  input  wire [1:0]    S_7_payload,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [1:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  wire       [3:0]    rr_0_0_S_0_payload;
  wire       [3:0]    rr_0_0_S_1_payload;
  wire       [0:0]    rr_0_0_bin;
  wire                rr_0_0_S_0_ready;
  wire                rr_0_0_S_1_ready;
  wire                rr_0_0_M_valid;
  wire       [3:0]    rr_0_0_M_payload;
  wire       [1:0]    rr_1_0_bin;
  wire                rr_1_0_S_0_ready;
  wire                rr_1_0_S_1_ready;
  wire                rr_1_0_S_2_ready;
  wire                rr_1_0_S_3_ready;
  wire                rr_1_0_M_valid;
  wire       [1:0]    rr_1_0_M_payload;
  wire       [1:0]    rr_1_1_bin;
  wire                rr_1_1_S_0_ready;
  wire                rr_1_1_S_1_ready;
  wire                rr_1_1_S_2_ready;
  wire                rr_1_1_S_3_ready;
  wire                rr_1_1_M_valid;
  wire       [1:0]    rr_1_1_M_payload;
  wire       [1:0]    _zz_bin;

  assign _zz_bin = (rr_0_0_M_payload >>> 2'd2);
  CX_Roundrobin_u4_h2 rr_0_0 (
    .bin         (rr_0_0_bin             ), //o
    .S_0_valid   (rr_1_0_M_valid         ), //i
    .S_0_ready   (rr_0_0_S_0_ready       ), //o
    .S_0_payload (rr_0_0_S_0_payload[3:0]), //i
    .S_1_valid   (rr_1_1_M_valid         ), //i
    .S_1_ready   (rr_0_0_S_1_ready       ), //o
    .S_1_payload (rr_0_0_S_1_payload[3:0]), //i
    .M_valid     (rr_0_0_M_valid         ), //o
    .M_ready     (M_ready                ), //i
    .M_payload   (rr_0_0_M_payload[3:0]  ), //o
    .clk         (clk                    ), //i
    .reset       (reset                  )  //i
  );
  CX_Roundrobin_u2_h4 rr_1_0 (
    .bin         (rr_1_0_bin[1:0]      ), //o
    .S_0_valid   (S_0_valid            ), //i
    .S_0_ready   (rr_1_0_S_0_ready     ), //o
    .S_0_payload (S_0_payload[1:0]     ), //i
    .S_1_valid   (S_1_valid            ), //i
    .S_1_ready   (rr_1_0_S_1_ready     ), //o
    .S_1_payload (S_1_payload[1:0]     ), //i
    .S_2_valid   (S_2_valid            ), //i
    .S_2_ready   (rr_1_0_S_2_ready     ), //o
    .S_2_payload (S_2_payload[1:0]     ), //i
    .S_3_valid   (S_3_valid            ), //i
    .S_3_ready   (rr_1_0_S_3_ready     ), //o
    .S_3_payload (S_3_payload[1:0]     ), //i
    .M_valid     (rr_1_0_M_valid       ), //o
    .M_ready     (rr_0_0_S_0_ready     ), //i
    .M_payload   (rr_1_0_M_payload[1:0]), //o
    .clk         (clk                  ), //i
    .reset       (reset                )  //i
  );
  CX_Roundrobin_u2_h4 rr_1_1 (
    .bin         (rr_1_1_bin[1:0]      ), //o
    .S_0_valid   (S_4_valid            ), //i
    .S_0_ready   (rr_1_1_S_0_ready     ), //o
    .S_0_payload (S_4_payload[1:0]     ), //i
    .S_1_valid   (S_5_valid            ), //i
    .S_1_ready   (rr_1_1_S_1_ready     ), //o
    .S_1_payload (S_5_payload[1:0]     ), //i
    .S_2_valid   (S_6_valid            ), //i
    .S_2_ready   (rr_1_1_S_2_ready     ), //o
    .S_2_payload (S_6_payload[1:0]     ), //i
    .S_3_valid   (S_7_valid            ), //i
    .S_3_ready   (rr_1_1_S_3_ready     ), //o
    .S_3_payload (S_7_payload[1:0]     ), //i
    .M_valid     (rr_1_1_M_valid       ), //o
    .M_ready     (rr_0_0_S_1_ready     ), //i
    .M_payload   (rr_1_1_M_payload[1:0]), //o
    .clk         (clk                  ), //i
    .reset       (reset                )  //i
  );
  assign rr_0_0_S_0_payload = {rr_1_0_bin,rr_1_0_M_payload};
  assign rr_0_0_S_1_payload = {rr_1_1_bin,rr_1_1_M_payload};
  assign S_0_ready = rr_1_0_S_0_ready;
  assign S_1_ready = rr_1_0_S_1_ready;
  assign S_2_ready = rr_1_0_S_2_ready;
  assign S_3_ready = rr_1_0_S_3_ready;
  assign S_4_ready = rr_1_1_S_0_ready;
  assign S_5_ready = rr_1_1_S_1_ready;
  assign S_6_ready = rr_1_1_S_2_ready;
  assign S_7_ready = rr_1_1_S_3_ready;
  assign M_valid = rr_0_0_M_valid;
  assign M_payload = rr_0_0_M_payload[1 : 0];
  assign bin = {rr_0_0_bin,_zz_bin};

endmodule

//CX_Roundrobin_u2_h4 replaced by CX_Roundrobin_u2_h4

module CX_Roundrobin_u2_h4 (
  output wire [1:0]    bin,
  input  wire          S_0_valid,
  output reg           S_0_ready,
  input  wire [1:0]    S_0_payload,
  input  wire          S_1_valid,
  output reg           S_1_ready,
  input  wire [1:0]    S_1_payload,
  input  wire          S_2_valid,
  output reg           S_2_ready,
  input  wire [1:0]    S_2_payload,
  input  wire          S_3_valid,
  output reg           S_3_ready,
  input  wire [1:0]    S_3_payload,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [1:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  wire       [3:0]    hotHigh_hot;
  wire       [3:0]    hotLow_hot;
  wire       [1:0]    hotHigh_bin;
  wire                hotHigh_zero;
  wire       [1:0]    hotLow_bin;
  wire                hotLow_zero;
  wire       [3:0]    _zz_maskHigh;
  reg        [1:0]    _zz__zz_M_payload;
  wire       [3:0]    maskHigh;
  reg        [3:0]    maskLow;
  reg        [3:0]    req;
  wire       [3:0]    _zz_1;
  wire                _zz_S_0_ready;
  wire                rdy;
  wire                vld;
  wire       [1:0]    nx;
  reg                 vld_regNextWhen;
  reg        [1:0]    _zz_M_payload;
  reg        [1:0]    nx_regNextWhen;

  assign _zz_maskHigh = ((~ 4'b0000) <<< bin);
  CX_Hot2binLowFirst_b2 hotHigh (
    .hot  (hotHigh_hot[3:0]), //i
    .bin  (hotHigh_bin[1:0]), //o
    .zero (hotHigh_zero    )  //o
  );
  CX_Hot2binLowFirst_b2 hotLow (
    .hot  (hotLow_hot[3:0]), //i
    .bin  (hotLow_bin[1:0]), //o
    .zero (hotLow_zero    )  //o
  );
  always @(*) begin
    case(nx)
      2'b00 : _zz__zz_M_payload = S_0_payload;
      2'b01 : _zz__zz_M_payload = S_1_payload;
      2'b10 : _zz__zz_M_payload = S_2_payload;
      default : _zz__zz_M_payload = S_3_payload;
    endcase
  end

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

  assign _zz_1 = ({3'd0,1'b1} <<< bin);
  assign _zz_S_0_ready = (M_ready && M_valid);
  assign hotHigh_hot = (req & maskHigh);
  assign hotLow_hot = (req & maskLow);
  assign rdy = ((! M_valid) || M_ready);
  assign vld = ((! hotHigh_zero) || (! hotLow_zero));
  assign nx = (hotHigh_zero ? hotLow_bin : hotHigh_bin);
  assign M_valid = vld_regNextWhen;
  assign M_payload = _zz_M_payload;
  assign bin = nx_regNextWhen;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      vld_regNextWhen <= 1'b0;
      _zz_M_payload <= 2'b00;
    end else begin
      if(rdy) begin
        vld_regNextWhen <= vld;
      end
      if((rdy && vld)) begin
        _zz_M_payload <= _zz__zz_M_payload;
      end
    end
  end

  always @(posedge clk) begin
    if((rdy && vld)) begin
      nx_regNextWhen <= nx;
    end
  end


endmodule

module CX_Roundrobin_u4_h2 (
  output wire [0:0]    bin,
  input  wire          S_0_valid,
  output reg           S_0_ready,
  input  wire [3:0]    S_0_payload,
  input  wire          S_1_valid,
  output reg           S_1_ready,
  input  wire [3:0]    S_1_payload,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [3:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  wire       [1:0]    hotHigh_hot;
  wire       [1:0]    hotLow_hot;
  wire       [0:0]    hotHigh_bin;
  wire                hotHigh_zero;
  wire       [0:0]    hotLow_bin;
  wire                hotLow_zero;
  wire       [1:0]    _zz_maskHigh;
  reg        [3:0]    _zz__zz_M_payload;
  wire       [1:0]    maskHigh;
  reg        [1:0]    maskLow;
  reg        [1:0]    req;
  wire       [1:0]    _zz_1;
  wire                _zz_S_0_ready;
  wire                rdy;
  wire                vld;
  wire       [0:0]    nx;
  reg                 vld_regNextWhen;
  reg        [3:0]    _zz_M_payload;
  reg        [0:0]    nx_regNextWhen;

  assign _zz_maskHigh = ((~ 2'b00) <<< bin);
  CX_Hot2binLowFirst_b1 hotHigh (
    .hot  (hotHigh_hot[1:0]), //i
    .bin  (hotHigh_bin     ), //o
    .zero (hotHigh_zero    )  //o
  );
  CX_Hot2binLowFirst_b1 hotLow (
    .hot  (hotLow_hot[1:0]), //i
    .bin  (hotLow_bin     ), //o
    .zero (hotLow_zero    )  //o
  );
  always @(*) begin
    case(nx)
      1'b0 : _zz__zz_M_payload = S_0_payload;
      default : _zz__zz_M_payload = S_1_payload;
    endcase
  end

  assign maskHigh = (_zz_maskHigh <<< 1);
  always @(*) begin
    maskLow = (~ maskHigh);
    maskLow[bin] = (! M_valid);
  end

  always @(*) begin
    req[0] = S_0_valid;
    req[1] = S_1_valid;
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

  assign _zz_1 = ({1'd0,1'b1} <<< bin);
  assign _zz_S_0_ready = (M_ready && M_valid);
  assign hotHigh_hot = (req & maskHigh);
  assign hotLow_hot = (req & maskLow);
  assign rdy = ((! M_valid) || M_ready);
  assign vld = ((! hotHigh_zero) || (! hotLow_zero));
  assign nx = (hotHigh_zero ? hotLow_bin : hotHigh_bin);
  assign M_valid = vld_regNextWhen;
  assign M_payload = _zz_M_payload;
  assign bin = nx_regNextWhen;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      vld_regNextWhen <= 1'b0;
      _zz_M_payload <= 4'b0000;
    end else begin
      if(rdy) begin
        vld_regNextWhen <= vld;
      end
      if((rdy && vld)) begin
        _zz_M_payload <= _zz__zz_M_payload;
      end
    end
  end

  always @(posedge clk) begin
    if((rdy && vld)) begin
      nx_regNextWhen <= nx;
    end
  end


endmodule

//CX_Hot2binLowFirst_b2 replaced by CX_Hot2binLowFirst_b2

//CX_Hot2binLowFirst_b2 replaced by CX_Hot2binLowFirst_b2

//CX_Hot2binLowFirst_b2 replaced by CX_Hot2binLowFirst_b2

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

//CX_Hot2binLowFirst_b1 replaced by CX_Hot2binLowFirst_b1

module CX_Hot2binLowFirst_b1 (
  input  wire [1:0]    hot,
  output reg  [0:0]    bin,
  output wire          zero
);


  always @(*) begin
    if((1'b1 == hot[0])) begin
        bin = 1'b0;
    end else if((1'b1 == hot[1])) begin
        bin = 1'b1;
    end else begin
        bin = 1'b0;
    end
  end

  assign zero = (hot == 2'b00);

endmodule
