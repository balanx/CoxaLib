// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : Ram1_m4_h256_w32
// Git hash  : 3403de512becf488d71d5cb07443d3acc4fd5c35
// https://github.com/balanx/Coxalib



module Ram1_m4_h256_w32 (
  input  wire          E,
  input  wire [3:0]    M,
  input  wire          W,
  input  wire [7:0]    A,
  input  wire [31:0]   D,
  output wire [31:0]   Q,
  input  wire          CK
);

  wire       [31:0]   mem_spinal_port0;
  wire       [31:0]   _zz_mem_port;
  wire       [3:0]    _zz_mem_port_1;
  wire                wen;
  wire                ren;
  reg        [31:0]   _zz_Q;
  (* ram_style = "auto" *) reg [7:0] mem_symbol0 [0:255];
  (* ram_style = "auto" *) reg [7:0] mem_symbol1 [0:255];
  (* ram_style = "auto" *) reg [7:0] mem_symbol2 [0:255];
  (* ram_style = "auto" *) reg [7:0] mem_symbol3 [0:255];

  assign _zz_mem_port = D;
  assign _zz_mem_port_1 = M;
  assign mem_spinal_port0[7 : 0] = mem_symbol0[A];
  assign mem_spinal_port0[15 : 8] = mem_symbol1[A];
  assign mem_spinal_port0[23 : 16] = mem_symbol2[A];
  assign mem_spinal_port0[31 : 24] = mem_symbol3[A];
  always @(posedge CK) begin
    if(_zz_mem_port_1[0] && wen) begin
      mem_symbol0[A] <= _zz_mem_port[7 : 0];
    end
    if(_zz_mem_port_1[1] && wen) begin
      mem_symbol1[A] <= _zz_mem_port[15 : 8];
    end
    if(_zz_mem_port_1[2] && wen) begin
      mem_symbol2[A] <= _zz_mem_port[23 : 16];
    end
    if(_zz_mem_port_1[3] && wen) begin
      mem_symbol3[A] <= _zz_mem_port[31 : 24];
    end
  end

  assign wen = (W && E);
  assign ren = ((! W) && E);
  assign Q = _zz_Q;
  always @(posedge CK) begin
    if(ren) begin
      _zz_Q <= mem_spinal_port0;
    end
  end


endmodule
