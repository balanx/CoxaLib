// Generator : SpinalHDL v1.12.0    git head : 1aa7d7b5732f11cca2dd83bacc2a4cb92ca8e5c9
// Component : Ram1_h16_w8
// Git hash  : 3403de512becf488d71d5cb07443d3acc4fd5c35
// https://github.com/balanx/Coxalib



module Ram1_h16_w8 (
  input  wire          E,
  input  wire          W,
  input  wire [3:0]    A,
  input  wire [7:0]    D,
  output wire [7:0]    Q,
  input  wire          CK
);

  wire       [7:0]    mem_spinal_port0;
  wire       [7:0]    _zz_mem_port;
  wire                wen;
  wire                ren;
  reg        [7:0]    _zz_Q;
  (* ram_style = "auto" *) reg [7:0] mem [0:15];

  assign _zz_mem_port = D;
  assign mem_spinal_port0 = mem[A];
  always @(posedge CK) begin
    if(wen) begin
      mem[A] <= _zz_mem_port;
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
