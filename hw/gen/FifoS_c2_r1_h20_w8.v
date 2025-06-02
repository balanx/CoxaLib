// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : FifoS_c2_r1_h20_w8
// Git hash  : 0ccfbb927b999c94e318d03edc3f767771d83daa



module FifoS_c2_r1_h20_w8 (
  output wire [4:0]    wused,
  input  wire          S_valid,
  output wire          S_ready,
  input  wire [7:0]    S_payload,
  output wire [4:0]    rused,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [7:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  wire       [5:0]    A_w_wpt;
  wire       [4:0]    A_w_wAddr;
  wire       [7:0]    A_w_wData;
  wire                A_w_wen;
  wire                A_w_full;
  wire       [4:0]    A_w_wused;
  wire                A_w_S_ready;
  wire       [5:0]    B_r_rpt;
  wire       [4:0]    B_r_rAddr;
  wire                B_r_ren;
  wire                B_r_empty;
  wire       [4:0]    B_r_rused;
  wire                B_r_M_valid;
  wire       [7:0]    B_r_M_payload;
  wire       [7:0]    mem_Q;

  CX_FifoWrite_h20_w8 A_w (
    .wpt       (A_w_wpt[5:0]  ), //o
    .rpt       (B_r_rpt[5:0]  ), //i
    .wAddr     (A_w_wAddr[4:0]), //o
    .wData     (A_w_wData[7:0]), //o
    .wen       (A_w_wen       ), //o
    .full      (A_w_full      ), //o
    .wused     (A_w_wused[4:0]), //o
    .S_valid   (S_valid       ), //i
    .S_ready   (A_w_S_ready   ), //o
    .S_payload (S_payload[7:0]), //i
    .clk       (clk           ), //i
    .reset     (reset         )  //i
  );
  CX_FifoRead_r1_h20_w8 B_r (
    .wpt       (A_w_wpt[5:0]      ), //i
    .rpt       (B_r_rpt[5:0]      ), //o
    .rAddr     (B_r_rAddr[4:0]    ), //o
    .rData     (mem_Q[7:0]        ), //i
    .ren       (B_r_ren           ), //o
    .empty     (B_r_empty         ), //o
    .rused     (B_r_rused[4:0]    ), //o
    .M_valid   (B_r_M_valid       ), //o
    .M_ready   (M_ready           ), //i
    .M_payload (B_r_M_payload[7:0]), //o
    .clk       (clk               ), //i
    .reset     (reset             )  //i
  );
  CX_Ram2S_h20_w8 mem (
    .E  (B_r_ren       ), //i
    .W  (A_w_wen       ), //i
    .AA (A_w_wAddr[4:0]), //i
    .AB (B_r_rAddr[4:0]), //i
    .D  (A_w_wData[7:0]), //i
    .Q  (mem_Q[7:0]    ), //o
    .CK (clk           )  //i
  );
  assign wused = A_w_wused;
  assign S_ready = A_w_S_ready;
  assign rused = B_r_rused;
  assign M_valid = B_r_M_valid;
  assign M_payload = B_r_M_payload;

endmodule

module CX_Ram2S_h20_w8 (
  input  wire          E,
  input  wire          W,
  input  wire [4:0]    AA,
  input  wire [4:0]    AB,
  input  wire [7:0]    D,
  output wire [7:0]    Q,
  input  wire          CK
);

  wire       [7:0]    areaA_mem_spinal_port1;
  wire       [7:0]    _zz_areaA_mem_port;
  reg                 _zz_1;
  wire       [7:0]    data;
  reg        [7:0]    data_regNextWhen;
  (* ram_style = "auto" *) reg [7:0] areaA_mem [0:19];

  assign _zz_areaA_mem_port = D;
  always @(posedge CK) begin
    if(_zz_1) begin
      areaA_mem[AA] <= _zz_areaA_mem_port;
    end
  end

  assign areaA_mem_spinal_port1 = areaA_mem[AB];
  always @(*) begin
    _zz_1 = 1'b0;
    if(W) begin
      _zz_1 = 1'b1;
    end
  end

  assign data = areaA_mem_spinal_port1;
  assign Q = data_regNextWhen;
  always @(posedge CK) begin
    if(E) begin
      data_regNextWhen <= data;
    end
  end


endmodule

module CX_FifoRead_r1_h20_w8 (
  input  wire [5:0]    wpt,
  output wire [5:0]    rpt,
  output wire [4:0]    rAddr,
  input  wire [7:0]    rData,
  output wire          ren,
  output wire          empty,
  output wire [4:0]    rused,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [7:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  wire                pipe_nxa;
  wire                pipe_M_valid;
  wire       [7:0]    pipe_M_payload;
  wire       [5:0]    _zz_rused;
  wire       [5:0]    _zz_rused_1;
  wire       [5:0]    _zz_rused_2;
  wire       [5:0]    _zz_rused_3;
  wire       [5:0]    _zz_rAddr;
  wire       [5:0]    _zz_rAddr_1;
  wire       [5:0]    _zz__zz_rpt_1;
  wire       [0:0]    _zz__zz_rpt_1_1;
  reg                 _zz_rpt;
  reg        [5:0]    _zz_rpt_1;
  reg        [5:0]    _zz_rpt_2;
  wire                _zz_1;
  wire                _zz_2;

  assign _zz_rused = ((rpt <= wpt) ? _zz_rused_1 : _zz_rused_2);
  assign _zz_rused_1 = (wpt - rpt);
  assign _zz_rused_2 = (_zz_rused_3 - rpt);
  assign _zz_rused_3 = (wpt + 6'h28);
  assign _zz_rAddr = ((rpt < 6'h14) ? rpt : _zz_rAddr_1);
  assign _zz_rAddr_1 = (rpt - 6'h14);
  assign _zz__zz_rpt_1_1 = _zz_rpt;
  assign _zz__zz_rpt_1 = {5'd0, _zz__zz_rpt_1_1};
  CX_RamRead_r1_w8 pipe (
    .data      (rData[7:0]         ), //i
    .ren       (ren                ), //i
    .nxa       (pipe_nxa           ), //o
    .M_valid   (pipe_M_valid       ), //o
    .M_ready   (M_ready            ), //i
    .M_payload (pipe_M_payload[7:0]), //o
    .clk       (clk                ), //i
    .reset     (reset              )  //i
  );
  assign M_valid = pipe_M_valid;
  assign M_payload = pipe_M_payload;
  assign ren = ((! empty) && pipe_nxa);
  assign rused = _zz_rused[4:0];
  assign empty = (rused == 5'h0);
  assign rAddr = _zz_rAddr[4:0];
  always @(*) begin
    _zz_rpt = 1'b0;
    if(ren) begin
      _zz_rpt = 1'b1;
    end
  end

  assign _zz_1 = (_zz_rpt_2 == 6'h27);
  assign _zz_2 = (_zz_1 && _zz_rpt);
  always @(*) begin
    if(_zz_2) begin
      _zz_rpt_1 = 6'h0;
    end else begin
      _zz_rpt_1 = (_zz_rpt_2 + _zz__zz_rpt_1);
    end
    if(1'b0) begin
      _zz_rpt_1 = 6'h0;
    end
  end

  assign rpt = _zz_rpt_2;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_rpt_2 <= 6'h0;
    end else begin
      _zz_rpt_2 <= _zz_rpt_1;
    end
  end


endmodule

module CX_FifoWrite_h20_w8 (
  output wire [5:0]    wpt,
  input  wire [5:0]    rpt,
  output wire [4:0]    wAddr,
  output wire [7:0]    wData,
  output wire          wen,
  output wire          full,
  output wire [4:0]    wused,
  input  wire          S_valid,
  output wire          S_ready,
  input  wire [7:0]    S_payload,
  input  wire          clk,
  input  wire          reset
);

  wire       [5:0]    _zz_wused;
  wire       [5:0]    _zz_wused_1;
  wire       [5:0]    _zz_wused_2;
  wire       [5:0]    _zz_wused_3;
  wire       [5:0]    _zz_wAddr;
  wire       [5:0]    _zz_wAddr_1;
  wire       [5:0]    _zz__zz_wpt_1;
  wire       [0:0]    _zz__zz_wpt_1_1;
  reg                 _zz_wpt;
  reg        [5:0]    _zz_wpt_1;
  reg        [5:0]    _zz_wpt_2;
  wire                _zz_1;
  wire                _zz_2;

  assign _zz_wused = ((rpt <= wpt) ? _zz_wused_1 : _zz_wused_2);
  assign _zz_wused_1 = (wpt - rpt);
  assign _zz_wused_2 = (_zz_wused_3 - rpt);
  assign _zz_wused_3 = (wpt + 6'h28);
  assign _zz_wAddr = ((wpt < 6'h14) ? wpt : _zz_wAddr_1);
  assign _zz_wAddr_1 = (wpt - 6'h14);
  assign _zz__zz_wpt_1_1 = _zz_wpt;
  assign _zz__zz_wpt_1 = {5'd0, _zz__zz_wpt_1_1};
  assign wData = S_payload;
  assign wen = ((! full) && S_valid);
  assign wused = _zz_wused[4:0];
  assign wAddr = _zz_wAddr[4:0];
  assign full = (wused == 5'h14);
  assign S_ready = (! full);
  always @(*) begin
    _zz_wpt = 1'b0;
    if(wen) begin
      _zz_wpt = 1'b1;
    end
  end

  assign _zz_1 = (_zz_wpt_2 == 6'h27);
  assign _zz_2 = (_zz_1 && _zz_wpt);
  always @(*) begin
    if(_zz_2) begin
      _zz_wpt_1 = 6'h0;
    end else begin
      _zz_wpt_1 = (_zz_wpt_2 + _zz__zz_wpt_1);
    end
    if(1'b0) begin
      _zz_wpt_1 = 6'h0;
    end
  end

  assign wpt = _zz_wpt_2;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_wpt_2 <= 6'h0;
    end else begin
      _zz_wpt_2 <= _zz_wpt_1;
    end
  end


endmodule

module CX_RamRead_r1_w8 (
  input  wire [7:0]    data,
  input  wire          ren,
  output wire          nxa,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [7:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  wire                ramRegout_S_ready;
  wire                ramRegout_M_valid;
  wire       [7:0]    ramRegout_M_payload;
  reg                 valid;

  CX_RamRegout_w8 ramRegout (
    .S_valid   (valid                   ), //i
    .S_ready   (ramRegout_S_ready       ), //o
    .S_payload (data[7:0]               ), //i
    .M_valid   (ramRegout_M_valid       ), //o
    .M_ready   (M_ready                 ), //i
    .M_payload (ramRegout_M_payload[7:0]), //o
    .clk       (clk                     ), //i
    .reset     (reset                   )  //i
  );
  assign M_valid = ramRegout_M_valid;
  assign M_payload = ramRegout_M_payload;
  assign nxa = ((! valid) || ramRegout_S_ready);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      valid <= 1'b0;
    end else begin
      if(nxa) begin
        valid <= ren;
      end
    end
  end


endmodule

module CX_RamRegout_w8 (
  input  wire          S_valid,
  output wire          S_ready,
  input  wire [7:0]    S_payload,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [7:0]    M_payload,
  input  wire          clk,
  input  wire          reset
);

  reg        [7:0]    payload_dly;
  wire                S_fire;
  reg                 fire_dly;
  wire                jammed;
  reg        [7:0]    payload_hold;
  reg                 valid_hold;

  assign S_fire = (S_valid && S_ready);
  assign S_ready = (M_ready || (! M_valid));
  assign jammed = (fire_dly && (! M_ready));
  assign M_valid = (valid_hold || fire_dly);
  assign M_payload = (valid_hold ? payload_hold : payload_dly);
  always @(posedge clk) begin
    payload_dly <= S_payload;
    if(jammed) begin
      payload_hold <= payload_dly;
    end
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      fire_dly <= 1'b0;
      valid_hold <= 1'b0;
    end else begin
      fire_dly <= S_fire;
      if(M_ready) begin
        valid_hold <= 1'b0;
      end else begin
        if(jammed) begin
          valid_hold <= 1'b1;
        end
      end
    end
  end


endmodule
