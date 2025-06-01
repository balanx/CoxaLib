// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : FifoA_h20_w8_c1_r0
// Git hash  : 0fec75bfcf7614934dda2997dc0ed1df5dbe6289

`timescale 1ns/1ps

module FifoA_h20_w8_c1_r0 (
  input  wire          CKA,
  input  wire          RSTA,
  input  wire          CKB,
  input  wire          RSTB,
  output wire [4:0]    wused,
  input  wire          S_valid,
  output wire          S_ready,
  input  wire [7:0]    S_payload,
  output wire [4:0]    rused,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [7:0]    M_payload
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
  wire       [5:0]    cdcRing_Q;
  wire       [5:0]    cdcRing_1_Q;
  wire       [7:0]    mem_Q;

  FifoWrite_h20_w8 A_w (
    .wpt       (A_w_wpt[5:0]    ), //o
    .rpt       (cdcRing_1_Q[5:0]), //i
    .wAddr     (A_w_wAddr[4:0]  ), //o
    .wData     (A_w_wData[7:0]  ), //o
    .wen       (A_w_wen         ), //o
    .full      (A_w_full        ), //o
    .wused     (A_w_wused[4:0]  ), //o
    .S_valid   (S_valid         ), //i
    .S_ready   (A_w_S_ready     ), //o
    .S_payload (S_payload[7:0]  ), //i
    .CKA       (CKA             ), //i
    .RSTA      (RSTA            )  //i
  );
  FifoRead_h20_h8_r0 B_r (
    .wpt       (cdcRing_Q[5:0]    ), //i
    .rpt       (B_r_rpt[5:0]      ), //o
    .rAddr     (B_r_rAddr[4:0]    ), //o
    .rData     (mem_Q[7:0]        ), //i
    .ren       (B_r_ren           ), //o
    .empty     (B_r_empty         ), //o
    .rused     (B_r_rused[4:0]    ), //o
    .M_valid   (B_r_M_valid       ), //o
    .M_ready   (M_ready           ), //i
    .M_payload (B_r_M_payload[7:0]), //o
    .CKB       (CKB               ), //i
    .RSTB      (RSTB              )  //i
  );
  CdcRing_c1_w6 cdcRing (
    .CKA  (CKA           ), //i
    .RSTA (RSTA          ), //i
    .CKB  (CKB           ), //i
    .RSTB (RSTB          ), //i
    .D    (A_w_wpt[5:0]  ), //i
    .Q    (cdcRing_Q[5:0])  //o
  );
  CdcRing_c1_w6 cdcRing_1 (
    .CKA  (CKB             ), //i
    .RSTA (RSTB            ), //i
    .CKB  (CKA             ), //i
    .RSTB (RSTA            ), //i
    .D    (B_r_rpt[5:0]    ), //i
    .Q    (cdcRing_1_Q[5:0])  //o
  );
  Ram2A_h20_w8 mem (
    .E   (B_r_ren       ), //i
    .W   (A_w_wen       ), //i
    .AA  (A_w_wAddr[4:0]), //i
    .AB  (B_r_rAddr[4:0]), //i
    .D   (A_w_wData[7:0]), //i
    .Q   (mem_Q[7:0]    ), //o
    .CKA (CKA           ), //i
    .CKB (CKB           )  //i
  );
  assign wused = A_w_wused;
  assign S_ready = A_w_S_ready;
  assign rused = B_r_rused;
  assign M_valid = B_r_M_valid;
  assign M_payload = B_r_M_payload;

endmodule

module Ram2A_h20_w8 (
  input  wire          E,
  input  wire          W,
  input  wire [4:0]    AA,
  input  wire [4:0]    AB,
  input  wire [7:0]    D,
  output wire [7:0]    Q,
  input  wire          CKA,
  input  wire          CKB
);

  wire       [7:0]    areaA_mem_spinal_port1;
  wire       [7:0]    _zz_areaA_mem_port;
  reg                 _zz_1;
  wire       [7:0]    data;
  reg        [7:0]    data_regNextWhen;
  (* ram_style = "auto" *) reg [7:0] areaA_mem [0:19];

  assign _zz_areaA_mem_port = D;
  always @(posedge CKA) begin
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
  always @(posedge CKB) begin
    if(E) begin
      data_regNextWhen <= data;
    end
  end


endmodule

//CdcRing_c1_w6 replaced by CdcRing_c1_w6

module CdcRing_c1_w6 (
  input  wire          CKA,
  input  wire          RSTA,
  input  wire          CKB,
  input  wire          RSTB,
  input  wire [5:0]    D,
  output wire [5:0]    Q
);

  wire                a2b_fb;
  wire       [5:0]    a2b_Q;
  wire                b2a_Q;

  CdcFlip_c1_w6_r1 a2b (
    .CKA  (CKA       ), //i
    .RSTA (RSTA      ), //i
    .CKB  (CKB       ), //i
    .RSTB (RSTB      ), //i
    .fa   (b2a_Q     ), //i
    .fb   (a2b_fb    ), //o
    .D    (D[5:0]    ), //i
    .Q    (a2b_Q[5:0])  //o
  );
  CdcSingle_c1 b2a (
    .CKA  (CKB   ), //i
    .RSTA (RSTB  ), //i
    .CKB  (CKA   ), //i
    .RSTB (RSTA  ), //i
    .D    (a2b_fb), //i
    .Q    (b2a_Q )  //o
  );
  assign Q = a2b_Q;

endmodule

module FifoRead_h20_h8_r0 (
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
  input  wire          CKB,
  input  wire          RSTB
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
  RamRead_w8_r0 pipe (
    .data      (rData[7:0]         ), //i
    .ren       (ren                ), //i
    .nxa       (pipe_nxa           ), //o
    .M_valid   (pipe_M_valid       ), //o
    .M_ready   (M_ready            ), //i
    .M_payload (pipe_M_payload[7:0]), //o
    .CKB       (CKB                ), //i
    .RSTB      (RSTB               )  //i
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
  always @(posedge CKB or posedge RSTB) begin
    if(RSTB) begin
      _zz_rpt_2 <= 6'h0;
    end else begin
      _zz_rpt_2 <= _zz_rpt_1;
    end
  end


endmodule

module FifoWrite_h20_w8 (
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
  input  wire          CKA,
  input  wire          RSTA
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
  always @(posedge CKA or posedge RSTA) begin
    if(RSTA) begin
      _zz_wpt_2 <= 6'h0;
    end else begin
      _zz_wpt_2 <= _zz_wpt_1;
    end
  end


endmodule

//CdcSingle_c1 replaced by CdcSingle_c1

//CdcFlip_c1_w6_r1 replaced by CdcFlip_c1_w6_r1

//CdcSingle_c1 replaced by CdcSingle_c1

module CdcFlip_c1_w6_r1 (
  input  wire          CKA,
  input  wire          RSTA,
  input  wire          CKB,
  input  wire          RSTB,
  input  wire          fa,
  output wire          fb,
  input  wire [5:0]    D,
  output wire [5:0]    Q
);

  wire                cdc_D;
  wire                cdc_Q;
  reg                 A_x;
  wire                A_y;
  reg        [5:0]    A_di;
  reg                 B_x;
  wire                B_y;
  (* async_reg = "true" *) reg        [5:0]    B_dj;

  CdcSingle_c1 cdc (
    .CKA  (CKA  ), //i
    .RSTA (RSTA ), //i
    .CKB  (CKB  ), //i
    .RSTB (RSTB ), //i
    .D    (cdc_D), //i
    .Q    (cdc_Q)  //o
  );
  assign fb = cdc_Q;
  assign A_y = (A_x == fa);
  assign cdc_D = (A_y ? (! A_x) : A_x);
  assign B_y = (B_x ^ cdc_Q);
  assign Q = B_dj;
  always @(posedge CKA or posedge RSTA) begin
    if(RSTA) begin
      A_x <= 1'b0;
      A_di <= 6'h0;
    end else begin
      if(A_y) begin
        A_x <= (! A_x);
      end
      if(A_y) begin
        A_di <= D;
      end
    end
  end

  always @(posedge CKB or posedge RSTB) begin
    if(RSTB) begin
      B_x <= 1'b0;
      B_dj <= 6'h0;
    end else begin
      B_x <= cdc_Q;
      if(B_y) begin
        B_dj <= A_di;
      end
    end
  end


endmodule

module RamRead_w8_r0 (
  input  wire [7:0]    data,
  input  wire          ren,
  output wire          nxa,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [7:0]    M_payload,
  input  wire          CKB,
  input  wire          RSTB
);

  reg                 valid;

  assign nxa = ((! M_valid) || M_ready);
  assign M_valid = valid;
  assign M_payload = data;
  always @(posedge CKB or posedge RSTB) begin
    if(RSTB) begin
      valid <= 1'b0;
    end else begin
      if(nxa) begin
        valid <= ren;
      end
    end
  end


endmodule

//CdcSingle_c1 replaced by CdcSingle_c1

module CdcSingle_c1 (
  input  wire          CKA,
  input  wire          RSTA,
  input  wire          CKB,
  input  wire          RSTB,
  input  wire          D,
  output wire          Q
);

  wire       [0:0]    _zz_B_dk;
  wire       [1:0]    _zz_B_dk_1;
  reg                 A_di;
  (* async_reg = "true" *) reg                 B_dj;
  reg        [0:0]    B_dk;

  assign _zz_B_dk_1 = {B_dk,B_dj};
  assign _zz_B_dk = _zz_B_dk_1[0:0];
  assign Q = B_dk[0];
  always @(posedge CKA or posedge RSTA) begin
    if(RSTA) begin
      A_di <= 1'b0;
    end else begin
      A_di <= D;
    end
  end

  always @(posedge CKB or posedge RSTB) begin
    if(RSTB) begin
      B_dj <= 1'b0;
      B_dk <= 1'b0;
    end else begin
      B_dj <= A_di;
      B_dk <= _zz_B_dk;
    end
  end


endmodule
