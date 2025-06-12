// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : RoundrobinTree_u0_h2_h4_h8
// Git hash  : 1ca958c88ee1acae0918d8664950ea9447df20f2



module RoundrobinTree_u0_h2_h4_h8 (
  output wire [5:0]    bin,
  input  wire          S_0_valid,
  output wire          S_0_ready,
  input  wire          S_1_valid,
  output wire          S_1_ready,
  input  wire          S_2_valid,
  output wire          S_2_ready,
  input  wire          S_3_valid,
  output wire          S_3_ready,
  input  wire          S_4_valid,
  output wire          S_4_ready,
  input  wire          S_5_valid,
  output wire          S_5_ready,
  input  wire          S_6_valid,
  output wire          S_6_ready,
  input  wire          S_7_valid,
  output wire          S_7_ready,
  input  wire          S_8_valid,
  output wire          S_8_ready,
  input  wire          S_9_valid,
  output wire          S_9_ready,
  input  wire          S_10_valid,
  output wire          S_10_ready,
  input  wire          S_11_valid,
  output wire          S_11_ready,
  input  wire          S_12_valid,
  output wire          S_12_ready,
  input  wire          S_13_valid,
  output wire          S_13_ready,
  input  wire          S_14_valid,
  output wire          S_14_ready,
  input  wire          S_15_valid,
  output wire          S_15_ready,
  input  wire          S_16_valid,
  output wire          S_16_ready,
  input  wire          S_17_valid,
  output wire          S_17_ready,
  input  wire          S_18_valid,
  output wire          S_18_ready,
  input  wire          S_19_valid,
  output wire          S_19_ready,
  input  wire          S_20_valid,
  output wire          S_20_ready,
  input  wire          S_21_valid,
  output wire          S_21_ready,
  input  wire          S_22_valid,
  output wire          S_22_ready,
  input  wire          S_23_valid,
  output wire          S_23_ready,
  input  wire          S_24_valid,
  output wire          S_24_ready,
  input  wire          S_25_valid,
  output wire          S_25_ready,
  input  wire          S_26_valid,
  output wire          S_26_ready,
  input  wire          S_27_valid,
  output wire          S_27_ready,
  input  wire          S_28_valid,
  output wire          S_28_ready,
  input  wire          S_29_valid,
  output wire          S_29_ready,
  input  wire          S_30_valid,
  output wire          S_30_ready,
  input  wire          S_31_valid,
  output wire          S_31_ready,
  input  wire          S_32_valid,
  output wire          S_32_ready,
  input  wire          S_33_valid,
  output wire          S_33_ready,
  input  wire          S_34_valid,
  output wire          S_34_ready,
  input  wire          S_35_valid,
  output wire          S_35_ready,
  input  wire          S_36_valid,
  output wire          S_36_ready,
  input  wire          S_37_valid,
  output wire          S_37_ready,
  input  wire          S_38_valid,
  output wire          S_38_ready,
  input  wire          S_39_valid,
  output wire          S_39_ready,
  input  wire          S_40_valid,
  output wire          S_40_ready,
  input  wire          S_41_valid,
  output wire          S_41_ready,
  input  wire          S_42_valid,
  output wire          S_42_ready,
  input  wire          S_43_valid,
  output wire          S_43_ready,
  input  wire          S_44_valid,
  output wire          S_44_ready,
  input  wire          S_45_valid,
  output wire          S_45_ready,
  input  wire          S_46_valid,
  output wire          S_46_ready,
  input  wire          S_47_valid,
  output wire          S_47_ready,
  input  wire          S_48_valid,
  output wire          S_48_ready,
  input  wire          S_49_valid,
  output wire          S_49_ready,
  input  wire          S_50_valid,
  output wire          S_50_ready,
  input  wire          S_51_valid,
  output wire          S_51_ready,
  input  wire          S_52_valid,
  output wire          S_52_ready,
  input  wire          S_53_valid,
  output wire          S_53_ready,
  input  wire          S_54_valid,
  output wire          S_54_ready,
  input  wire          S_55_valid,
  output wire          S_55_ready,
  input  wire          S_56_valid,
  output wire          S_56_ready,
  input  wire          S_57_valid,
  output wire          S_57_ready,
  input  wire          S_58_valid,
  output wire          S_58_ready,
  input  wire          S_59_valid,
  output wire          S_59_ready,
  input  wire          S_60_valid,
  output wire          S_60_ready,
  input  wire          S_61_valid,
  output wire          S_61_ready,
  input  wire          S_62_valid,
  output wire          S_62_ready,
  input  wire          S_63_valid,
  output wire          S_63_ready,
  output wire          M_valid,
  input  wire          M_ready,
  input  wire          clk,
  input  wire          reset
);

  wire       [4:0]    rr_0_0_S_0_payload;
  wire       [4:0]    rr_0_0_S_1_payload;
  wire       [2:0]    rr_1_0_S_0_payload;
  wire       [2:0]    rr_1_0_S_1_payload;
  wire       [2:0]    rr_1_0_S_2_payload;
  wire       [2:0]    rr_1_0_S_3_payload;
  wire       [2:0]    rr_1_1_S_0_payload;
  wire       [2:0]    rr_1_1_S_1_payload;
  wire       [2:0]    rr_1_1_S_2_payload;
  wire       [2:0]    rr_1_1_S_3_payload;
  wire       [0:0]    rr_0_0_bin;
  wire                rr_0_0_S_0_ready;
  wire                rr_0_0_S_1_ready;
  wire                rr_0_0_M_valid;
  wire       [4:0]    rr_0_0_M_payload;
  wire       [1:0]    rr_1_0_bin;
  wire                rr_1_0_S_0_ready;
  wire                rr_1_0_S_1_ready;
  wire                rr_1_0_S_2_ready;
  wire                rr_1_0_S_3_ready;
  wire                rr_1_0_M_valid;
  wire       [2:0]    rr_1_0_M_payload;
  wire       [1:0]    rr_1_1_bin;
  wire                rr_1_1_S_0_ready;
  wire                rr_1_1_S_1_ready;
  wire                rr_1_1_S_2_ready;
  wire                rr_1_1_S_3_ready;
  wire                rr_1_1_M_valid;
  wire       [2:0]    rr_1_1_M_payload;
  wire       [2:0]    rr_2_0_bin;
  wire                rr_2_0_S_0_ready;
  wire                rr_2_0_S_1_ready;
  wire                rr_2_0_S_2_ready;
  wire                rr_2_0_S_3_ready;
  wire                rr_2_0_S_4_ready;
  wire                rr_2_0_S_5_ready;
  wire                rr_2_0_S_6_ready;
  wire                rr_2_0_S_7_ready;
  wire                rr_2_0_M_valid;
  wire       [2:0]    rr_2_1_bin;
  wire                rr_2_1_S_0_ready;
  wire                rr_2_1_S_1_ready;
  wire                rr_2_1_S_2_ready;
  wire                rr_2_1_S_3_ready;
  wire                rr_2_1_S_4_ready;
  wire                rr_2_1_S_5_ready;
  wire                rr_2_1_S_6_ready;
  wire                rr_2_1_S_7_ready;
  wire                rr_2_1_M_valid;
  wire       [2:0]    rr_2_2_bin;
  wire                rr_2_2_S_0_ready;
  wire                rr_2_2_S_1_ready;
  wire                rr_2_2_S_2_ready;
  wire                rr_2_2_S_3_ready;
  wire                rr_2_2_S_4_ready;
  wire                rr_2_2_S_5_ready;
  wire                rr_2_2_S_6_ready;
  wire                rr_2_2_S_7_ready;
  wire                rr_2_2_M_valid;
  wire       [2:0]    rr_2_3_bin;
  wire                rr_2_3_S_0_ready;
  wire                rr_2_3_S_1_ready;
  wire                rr_2_3_S_2_ready;
  wire                rr_2_3_S_3_ready;
  wire                rr_2_3_S_4_ready;
  wire                rr_2_3_S_5_ready;
  wire                rr_2_3_S_6_ready;
  wire                rr_2_3_S_7_ready;
  wire                rr_2_3_M_valid;
  wire       [2:0]    rr_2_4_bin;
  wire                rr_2_4_S_0_ready;
  wire                rr_2_4_S_1_ready;
  wire                rr_2_4_S_2_ready;
  wire                rr_2_4_S_3_ready;
  wire                rr_2_4_S_4_ready;
  wire                rr_2_4_S_5_ready;
  wire                rr_2_4_S_6_ready;
  wire                rr_2_4_S_7_ready;
  wire                rr_2_4_M_valid;
  wire       [2:0]    rr_2_5_bin;
  wire                rr_2_5_S_0_ready;
  wire                rr_2_5_S_1_ready;
  wire                rr_2_5_S_2_ready;
  wire                rr_2_5_S_3_ready;
  wire                rr_2_5_S_4_ready;
  wire                rr_2_5_S_5_ready;
  wire                rr_2_5_S_6_ready;
  wire                rr_2_5_S_7_ready;
  wire                rr_2_5_M_valid;
  wire       [2:0]    rr_2_6_bin;
  wire                rr_2_6_S_0_ready;
  wire                rr_2_6_S_1_ready;
  wire                rr_2_6_S_2_ready;
  wire                rr_2_6_S_3_ready;
  wire                rr_2_6_S_4_ready;
  wire                rr_2_6_S_5_ready;
  wire                rr_2_6_S_6_ready;
  wire                rr_2_6_S_7_ready;
  wire                rr_2_6_M_valid;
  wire       [2:0]    rr_2_7_bin;
  wire                rr_2_7_S_0_ready;
  wire                rr_2_7_S_1_ready;
  wire                rr_2_7_S_2_ready;
  wire                rr_2_7_S_3_ready;
  wire                rr_2_7_S_4_ready;
  wire                rr_2_7_S_5_ready;
  wire                rr_2_7_S_6_ready;
  wire                rr_2_7_S_7_ready;
  wire                rr_2_7_M_valid;

  CX_Roundrobin_u5_h2 rr_0_0 (
    .bin         (rr_0_0_bin             ), //o
    .S_0_valid   (rr_1_0_M_valid         ), //i
    .S_0_ready   (rr_0_0_S_0_ready       ), //o
    .S_0_payload (rr_0_0_S_0_payload[4:0]), //i
    .S_1_valid   (rr_1_1_M_valid         ), //i
    .S_1_ready   (rr_0_0_S_1_ready       ), //o
    .S_1_payload (rr_0_0_S_1_payload[4:0]), //i
    .M_valid     (rr_0_0_M_valid         ), //o
    .M_ready     (M_ready                ), //i
    .M_payload   (rr_0_0_M_payload[4:0]  ), //o
    .clk         (clk                    ), //i
    .reset       (reset                  )  //i
  );
  CX_Roundrobin_u3_h4 rr_1_0 (
    .bin         (rr_1_0_bin[1:0]        ), //o
    .S_0_valid   (rr_2_0_M_valid         ), //i
    .S_0_ready   (rr_1_0_S_0_ready       ), //o
    .S_0_payload (rr_1_0_S_0_payload[2:0]), //i
    .S_1_valid   (rr_2_1_M_valid         ), //i
    .S_1_ready   (rr_1_0_S_1_ready       ), //o
    .S_1_payload (rr_1_0_S_1_payload[2:0]), //i
    .S_2_valid   (rr_2_2_M_valid         ), //i
    .S_2_ready   (rr_1_0_S_2_ready       ), //o
    .S_2_payload (rr_1_0_S_2_payload[2:0]), //i
    .S_3_valid   (rr_2_3_M_valid         ), //i
    .S_3_ready   (rr_1_0_S_3_ready       ), //o
    .S_3_payload (rr_1_0_S_3_payload[2:0]), //i
    .M_valid     (rr_1_0_M_valid         ), //o
    .M_ready     (rr_0_0_S_0_ready       ), //i
    .M_payload   (rr_1_0_M_payload[2:0]  ), //o
    .clk         (clk                    ), //i
    .reset       (reset                  )  //i
  );
  CX_Roundrobin_u3_h4 rr_1_1 (
    .bin         (rr_1_1_bin[1:0]        ), //o
    .S_0_valid   (rr_2_4_M_valid         ), //i
    .S_0_ready   (rr_1_1_S_0_ready       ), //o
    .S_0_payload (rr_1_1_S_0_payload[2:0]), //i
    .S_1_valid   (rr_2_5_M_valid         ), //i
    .S_1_ready   (rr_1_1_S_1_ready       ), //o
    .S_1_payload (rr_1_1_S_1_payload[2:0]), //i
    .S_2_valid   (rr_2_6_M_valid         ), //i
    .S_2_ready   (rr_1_1_S_2_ready       ), //o
    .S_2_payload (rr_1_1_S_2_payload[2:0]), //i
    .S_3_valid   (rr_2_7_M_valid         ), //i
    .S_3_ready   (rr_1_1_S_3_ready       ), //o
    .S_3_payload (rr_1_1_S_3_payload[2:0]), //i
    .M_valid     (rr_1_1_M_valid         ), //o
    .M_ready     (rr_0_0_S_1_ready       ), //i
    .M_payload   (rr_1_1_M_payload[2:0]  ), //o
    .clk         (clk                    ), //i
    .reset       (reset                  )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_0 (
    .bin       (rr_2_0_bin[2:0] ), //o
    .S_0_valid (S_0_valid       ), //i
    .S_0_ready (rr_2_0_S_0_ready), //o
    .S_1_valid (S_1_valid       ), //i
    .S_1_ready (rr_2_0_S_1_ready), //o
    .S_2_valid (S_2_valid       ), //i
    .S_2_ready (rr_2_0_S_2_ready), //o
    .S_3_valid (S_3_valid       ), //i
    .S_3_ready (rr_2_0_S_3_ready), //o
    .S_4_valid (S_4_valid       ), //i
    .S_4_ready (rr_2_0_S_4_ready), //o
    .S_5_valid (S_5_valid       ), //i
    .S_5_ready (rr_2_0_S_5_ready), //o
    .S_6_valid (S_6_valid       ), //i
    .S_6_ready (rr_2_0_S_6_ready), //o
    .S_7_valid (S_7_valid       ), //i
    .S_7_ready (rr_2_0_S_7_ready), //o
    .M_valid   (rr_2_0_M_valid  ), //o
    .M_ready   (rr_1_0_S_0_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_1 (
    .bin       (rr_2_1_bin[2:0] ), //o
    .S_0_valid (S_8_valid       ), //i
    .S_0_ready (rr_2_1_S_0_ready), //o
    .S_1_valid (S_9_valid       ), //i
    .S_1_ready (rr_2_1_S_1_ready), //o
    .S_2_valid (S_10_valid      ), //i
    .S_2_ready (rr_2_1_S_2_ready), //o
    .S_3_valid (S_11_valid      ), //i
    .S_3_ready (rr_2_1_S_3_ready), //o
    .S_4_valid (S_12_valid      ), //i
    .S_4_ready (rr_2_1_S_4_ready), //o
    .S_5_valid (S_13_valid      ), //i
    .S_5_ready (rr_2_1_S_5_ready), //o
    .S_6_valid (S_14_valid      ), //i
    .S_6_ready (rr_2_1_S_6_ready), //o
    .S_7_valid (S_15_valid      ), //i
    .S_7_ready (rr_2_1_S_7_ready), //o
    .M_valid   (rr_2_1_M_valid  ), //o
    .M_ready   (rr_1_0_S_1_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_2 (
    .bin       (rr_2_2_bin[2:0] ), //o
    .S_0_valid (S_16_valid      ), //i
    .S_0_ready (rr_2_2_S_0_ready), //o
    .S_1_valid (S_17_valid      ), //i
    .S_1_ready (rr_2_2_S_1_ready), //o
    .S_2_valid (S_18_valid      ), //i
    .S_2_ready (rr_2_2_S_2_ready), //o
    .S_3_valid (S_19_valid      ), //i
    .S_3_ready (rr_2_2_S_3_ready), //o
    .S_4_valid (S_20_valid      ), //i
    .S_4_ready (rr_2_2_S_4_ready), //o
    .S_5_valid (S_21_valid      ), //i
    .S_5_ready (rr_2_2_S_5_ready), //o
    .S_6_valid (S_22_valid      ), //i
    .S_6_ready (rr_2_2_S_6_ready), //o
    .S_7_valid (S_23_valid      ), //i
    .S_7_ready (rr_2_2_S_7_ready), //o
    .M_valid   (rr_2_2_M_valid  ), //o
    .M_ready   (rr_1_0_S_2_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_3 (
    .bin       (rr_2_3_bin[2:0] ), //o
    .S_0_valid (S_24_valid      ), //i
    .S_0_ready (rr_2_3_S_0_ready), //o
    .S_1_valid (S_25_valid      ), //i
    .S_1_ready (rr_2_3_S_1_ready), //o
    .S_2_valid (S_26_valid      ), //i
    .S_2_ready (rr_2_3_S_2_ready), //o
    .S_3_valid (S_27_valid      ), //i
    .S_3_ready (rr_2_3_S_3_ready), //o
    .S_4_valid (S_28_valid      ), //i
    .S_4_ready (rr_2_3_S_4_ready), //o
    .S_5_valid (S_29_valid      ), //i
    .S_5_ready (rr_2_3_S_5_ready), //o
    .S_6_valid (S_30_valid      ), //i
    .S_6_ready (rr_2_3_S_6_ready), //o
    .S_7_valid (S_31_valid      ), //i
    .S_7_ready (rr_2_3_S_7_ready), //o
    .M_valid   (rr_2_3_M_valid  ), //o
    .M_ready   (rr_1_0_S_3_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_4 (
    .bin       (rr_2_4_bin[2:0] ), //o
    .S_0_valid (S_32_valid      ), //i
    .S_0_ready (rr_2_4_S_0_ready), //o
    .S_1_valid (S_33_valid      ), //i
    .S_1_ready (rr_2_4_S_1_ready), //o
    .S_2_valid (S_34_valid      ), //i
    .S_2_ready (rr_2_4_S_2_ready), //o
    .S_3_valid (S_35_valid      ), //i
    .S_3_ready (rr_2_4_S_3_ready), //o
    .S_4_valid (S_36_valid      ), //i
    .S_4_ready (rr_2_4_S_4_ready), //o
    .S_5_valid (S_37_valid      ), //i
    .S_5_ready (rr_2_4_S_5_ready), //o
    .S_6_valid (S_38_valid      ), //i
    .S_6_ready (rr_2_4_S_6_ready), //o
    .S_7_valid (S_39_valid      ), //i
    .S_7_ready (rr_2_4_S_7_ready), //o
    .M_valid   (rr_2_4_M_valid  ), //o
    .M_ready   (rr_1_1_S_0_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_5 (
    .bin       (rr_2_5_bin[2:0] ), //o
    .S_0_valid (S_40_valid      ), //i
    .S_0_ready (rr_2_5_S_0_ready), //o
    .S_1_valid (S_41_valid      ), //i
    .S_1_ready (rr_2_5_S_1_ready), //o
    .S_2_valid (S_42_valid      ), //i
    .S_2_ready (rr_2_5_S_2_ready), //o
    .S_3_valid (S_43_valid      ), //i
    .S_3_ready (rr_2_5_S_3_ready), //o
    .S_4_valid (S_44_valid      ), //i
    .S_4_ready (rr_2_5_S_4_ready), //o
    .S_5_valid (S_45_valid      ), //i
    .S_5_ready (rr_2_5_S_5_ready), //o
    .S_6_valid (S_46_valid      ), //i
    .S_6_ready (rr_2_5_S_6_ready), //o
    .S_7_valid (S_47_valid      ), //i
    .S_7_ready (rr_2_5_S_7_ready), //o
    .M_valid   (rr_2_5_M_valid  ), //o
    .M_ready   (rr_1_1_S_1_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_6 (
    .bin       (rr_2_6_bin[2:0] ), //o
    .S_0_valid (S_48_valid      ), //i
    .S_0_ready (rr_2_6_S_0_ready), //o
    .S_1_valid (S_49_valid      ), //i
    .S_1_ready (rr_2_6_S_1_ready), //o
    .S_2_valid (S_50_valid      ), //i
    .S_2_ready (rr_2_6_S_2_ready), //o
    .S_3_valid (S_51_valid      ), //i
    .S_3_ready (rr_2_6_S_3_ready), //o
    .S_4_valid (S_52_valid      ), //i
    .S_4_ready (rr_2_6_S_4_ready), //o
    .S_5_valid (S_53_valid      ), //i
    .S_5_ready (rr_2_6_S_5_ready), //o
    .S_6_valid (S_54_valid      ), //i
    .S_6_ready (rr_2_6_S_6_ready), //o
    .S_7_valid (S_55_valid      ), //i
    .S_7_ready (rr_2_6_S_7_ready), //o
    .M_valid   (rr_2_6_M_valid  ), //o
    .M_ready   (rr_1_1_S_2_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  CX_Roundrobin_u0_h8 rr_2_7 (
    .bin       (rr_2_7_bin[2:0] ), //o
    .S_0_valid (S_56_valid      ), //i
    .S_0_ready (rr_2_7_S_0_ready), //o
    .S_1_valid (S_57_valid      ), //i
    .S_1_ready (rr_2_7_S_1_ready), //o
    .S_2_valid (S_58_valid      ), //i
    .S_2_ready (rr_2_7_S_2_ready), //o
    .S_3_valid (S_59_valid      ), //i
    .S_3_ready (rr_2_7_S_3_ready), //o
    .S_4_valid (S_60_valid      ), //i
    .S_4_ready (rr_2_7_S_4_ready), //o
    .S_5_valid (S_61_valid      ), //i
    .S_5_ready (rr_2_7_S_5_ready), //o
    .S_6_valid (S_62_valid      ), //i
    .S_6_ready (rr_2_7_S_6_ready), //o
    .S_7_valid (S_63_valid      ), //i
    .S_7_ready (rr_2_7_S_7_ready), //o
    .M_valid   (rr_2_7_M_valid  ), //o
    .M_ready   (rr_1_1_S_3_ready), //i
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  assign rr_0_0_S_0_payload = {rr_1_0_bin,rr_1_0_M_payload};
  assign rr_0_0_S_1_payload = {rr_1_1_bin,rr_1_1_M_payload};
  assign rr_1_0_S_0_payload = rr_2_0_bin;
  assign rr_1_0_S_1_payload = rr_2_1_bin;
  assign rr_1_0_S_2_payload = rr_2_2_bin;
  assign rr_1_0_S_3_payload = rr_2_3_bin;
  assign rr_1_1_S_0_payload = rr_2_4_bin;
  assign rr_1_1_S_1_payload = rr_2_5_bin;
  assign rr_1_1_S_2_payload = rr_2_6_bin;
  assign rr_1_1_S_3_payload = rr_2_7_bin;
  assign S_0_ready = rr_2_0_S_0_ready;
  assign S_1_ready = rr_2_0_S_1_ready;
  assign S_2_ready = rr_2_0_S_2_ready;
  assign S_3_ready = rr_2_0_S_3_ready;
  assign S_4_ready = rr_2_0_S_4_ready;
  assign S_5_ready = rr_2_0_S_5_ready;
  assign S_6_ready = rr_2_0_S_6_ready;
  assign S_7_ready = rr_2_0_S_7_ready;
  assign S_8_ready = rr_2_1_S_0_ready;
  assign S_9_ready = rr_2_1_S_1_ready;
  assign S_10_ready = rr_2_1_S_2_ready;
  assign S_11_ready = rr_2_1_S_3_ready;
  assign S_12_ready = rr_2_1_S_4_ready;
  assign S_13_ready = rr_2_1_S_5_ready;
  assign S_14_ready = rr_2_1_S_6_ready;
  assign S_15_ready = rr_2_1_S_7_ready;
  assign S_16_ready = rr_2_2_S_0_ready;
  assign S_17_ready = rr_2_2_S_1_ready;
  assign S_18_ready = rr_2_2_S_2_ready;
  assign S_19_ready = rr_2_2_S_3_ready;
  assign S_20_ready = rr_2_2_S_4_ready;
  assign S_21_ready = rr_2_2_S_5_ready;
  assign S_22_ready = rr_2_2_S_6_ready;
  assign S_23_ready = rr_2_2_S_7_ready;
  assign S_24_ready = rr_2_3_S_0_ready;
  assign S_25_ready = rr_2_3_S_1_ready;
  assign S_26_ready = rr_2_3_S_2_ready;
  assign S_27_ready = rr_2_3_S_3_ready;
  assign S_28_ready = rr_2_3_S_4_ready;
  assign S_29_ready = rr_2_3_S_5_ready;
  assign S_30_ready = rr_2_3_S_6_ready;
  assign S_31_ready = rr_2_3_S_7_ready;
  assign S_32_ready = rr_2_4_S_0_ready;
  assign S_33_ready = rr_2_4_S_1_ready;
  assign S_34_ready = rr_2_4_S_2_ready;
  assign S_35_ready = rr_2_4_S_3_ready;
  assign S_36_ready = rr_2_4_S_4_ready;
  assign S_37_ready = rr_2_4_S_5_ready;
  assign S_38_ready = rr_2_4_S_6_ready;
  assign S_39_ready = rr_2_4_S_7_ready;
  assign S_40_ready = rr_2_5_S_0_ready;
  assign S_41_ready = rr_2_5_S_1_ready;
  assign S_42_ready = rr_2_5_S_2_ready;
  assign S_43_ready = rr_2_5_S_3_ready;
  assign S_44_ready = rr_2_5_S_4_ready;
  assign S_45_ready = rr_2_5_S_5_ready;
  assign S_46_ready = rr_2_5_S_6_ready;
  assign S_47_ready = rr_2_5_S_7_ready;
  assign S_48_ready = rr_2_6_S_0_ready;
  assign S_49_ready = rr_2_6_S_1_ready;
  assign S_50_ready = rr_2_6_S_2_ready;
  assign S_51_ready = rr_2_6_S_3_ready;
  assign S_52_ready = rr_2_6_S_4_ready;
  assign S_53_ready = rr_2_6_S_5_ready;
  assign S_54_ready = rr_2_6_S_6_ready;
  assign S_55_ready = rr_2_6_S_7_ready;
  assign S_56_ready = rr_2_7_S_0_ready;
  assign S_57_ready = rr_2_7_S_1_ready;
  assign S_58_ready = rr_2_7_S_2_ready;
  assign S_59_ready = rr_2_7_S_3_ready;
  assign S_60_ready = rr_2_7_S_4_ready;
  assign S_61_ready = rr_2_7_S_5_ready;
  assign S_62_ready = rr_2_7_S_6_ready;
  assign S_63_ready = rr_2_7_S_7_ready;
  assign M_valid = rr_0_0_M_valid;
  assign bin = {rr_0_0_bin,rr_0_0_M_payload};

endmodule

//CX_Roundrobin_u0_h8 replaced by CX_Roundrobin_u0_h8

//CX_Roundrobin_u0_h8 replaced by CX_Roundrobin_u0_h8

//CX_Roundrobin_u0_h8 replaced by CX_Roundrobin_u0_h8

//CX_Roundrobin_u0_h8 replaced by CX_Roundrobin_u0_h8

//CX_Roundrobin_u0_h8 replaced by CX_Roundrobin_u0_h8

//CX_Roundrobin_u0_h8 replaced by CX_Roundrobin_u0_h8

//CX_Roundrobin_u0_h8 replaced by CX_Roundrobin_u0_h8

module CX_Roundrobin_u0_h8 (
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

//CX_Roundrobin_u3_h4 replaced by CX_Roundrobin_u3_h4

module CX_Roundrobin_u3_h4 (
  output wire [1:0]    bin,
  input  wire          S_0_valid,
  output reg           S_0_ready,
  input  wire [2:0]    S_0_payload,
  input  wire          S_1_valid,
  output reg           S_1_ready,
  input  wire [2:0]    S_1_payload,
  input  wire          S_2_valid,
  output reg           S_2_ready,
  input  wire [2:0]    S_2_payload,
  input  wire          S_3_valid,
  output reg           S_3_ready,
  input  wire [2:0]    S_3_payload,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [2:0]    M_payload,
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
  reg        [2:0]    _zz__zz_M_payload;
  wire       [3:0]    maskHigh;
  reg        [3:0]    maskLow;
  reg        [3:0]    req;
  wire       [3:0]    _zz_1;
  wire                _zz_S_0_ready;
  wire                rdy;
  wire                vld;
  wire       [1:0]    nx;
  reg                 vld_regNextWhen;
  reg        [2:0]    _zz_M_payload;
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
      _zz_M_payload <= 3'b000;
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

module CX_Roundrobin_u5_h2 (
  output wire [0:0]    bin,
  input  wire          S_0_valid,
  output reg           S_0_ready,
  input  wire [4:0]    S_0_payload,
  input  wire          S_1_valid,
  output reg           S_1_ready,
  input  wire [4:0]    S_1_payload,
  output wire          M_valid,
  input  wire          M_ready,
  output wire [4:0]    M_payload,
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
  reg        [4:0]    _zz__zz_M_payload;
  wire       [1:0]    maskHigh;
  reg        [1:0]    maskLow;
  reg        [1:0]    req;
  wire       [1:0]    _zz_1;
  wire                _zz_S_0_ready;
  wire                rdy;
  wire                vld;
  wire       [0:0]    nx;
  reg                 vld_regNextWhen;
  reg        [4:0]    _zz_M_payload;
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
      _zz_M_payload <= 5'h0;
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

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

//CX_Hot2binLowFirst_b3 replaced by CX_Hot2binLowFirst_b3

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
