// https://github.com/balanx/Coxalib

package coxa.lib

//import scala.language.postfixOps
import spinal.core.{UInt, _}
import spinal.lib._

// Single-Port
case class Ram1(depth: Int, dataWidth: Int) extends Component {

  val addrWidth = log2Up(depth)

  val io = new Bundle {
    val E = in Bool()
    val W = in Bool()
    val A = in UInt (log2Up(depth) bits)
    val D = in UInt(dataWidth bits)
    val Q = out UInt(dataWidth bits)

    val CK =  in Bool()
  }

  noIoPrefix()
  setDefinitionName(s"Ram1_${depth}_${dataWidth}")

  val mem = Mem(UInt(dataWidth bits), depth)
  mem.addAttribute("ram_style", "auto")

  val wen = ( io.W & io.E)
  val ren = (~io.W & io.E)
  val clk = ClockDomain(io.CK)

  //  val area_clk = new ClockingArea(ClockDomain(ClockDomain.current.readClockWire)) {
  val area_clk = new ClockingArea(clk) {
    when(wen) {
      mem(io.A) := io.D
    }

    io.Q := RegNextWhen(mem(io.A), ren)
  }

}


// Simple Dual-Port
case class Ram2(depth: Int, dataWidth: Int, clkA : ClockDomain = ClockDomain.current, clkB : ClockDomain = ClockDomain.current) extends Component {

  val addrWidth = log2Up(depth)
  val async = (clkA != clkB)

  val io = new Bundle {
    val E = in Bool()
    val W = in Bool()
    val AA, AB = in UInt (addrWidth bits)
    val D = in UInt (dataWidth bits)
    val Q = out UInt (dataWidth bits)

    val CK  = !async generate (in Bool())
    val CKA =  async generate (in Bool())
    val CKB =  async generate (in Bool())
  }

  noIoPrefix()
  val fname = if (async) "Ram2A" else "Ram2S"
  setDefinitionName(s"${fname}_${depth}_${dataWidth}")

//  val wen =  io.W & io.E
//  val ren = ~io.W & io.E
  val wen = io.W
  val ren = io.E

  val aClk = ClockDomain(if (async) io.CKA else io.CK)
  val bClk = ClockDomain(if (async) io.CKB else io.CK)
  bClk.setSyncWith(aClk)
  clkA.setSyncWith(aClk)
  clkB.setSyncWith(bClk)

  val data = UInt (dataWidth bits)

  val areaA = new ClockingArea(aClk) {
    val mem = Mem(UInt(dataWidth bits), depth)
    mem.addAttribute("ram_style", "auto")

    when(wen) {
      mem(io.AA) := io.D
    }
    data := mem(io.AB)
  }

  val areaB = new ClockingArea(bClk) {
    io.Q := RegNextWhen(data, ren)
  }


  def Write(enable: Bool, address: UInt, data: UInt): Unit = {
    if (async) io.CKA := clkA.readClockWire else io.CK := clkA.readClockWire

    io.W := enable
    io.AA := address
    io.D := data
  }

  def Read(enable: Bool, address: UInt): UInt = {
    if (async) io.CKB := clkB.readClockWire //else io.CK := clkB.readClockWire

    io.E := enable
    io.AB := address
    io.Q
  }

  //  if (depth < (1 << io.AA.getWidth)) {
  //    assert(io.AA >= depth, (L"AA(=${io.AA}) greater than or equal to depth") + s"(=$depth)")
  //    assert(io.AB >= depth, L"AB(=${io.AB}) greater than or equal to depth")
  //  }

}


/*
case class RamConflictR(
                 width: Int,
                 depth: Int) extends Component {

  val io = new Bundle {
    val CK = in Bool()
    val W  = in Bool()
    val D  = in UInt (width bits)
    val AA, AB = in UInt (log2Up(depth) bits)
    val ri = in Bool()
    val ro = out Bool()
    val qi = in UInt (width bits)
    val qo = out UInt (width bits)
  }

  noIoPrefix()
  setDefinitionName(s"RamConflictR_${width}_${depth}")

  val conflicted = io.W & io.ri & (io.AA === io.AB)
  io.ro := ~conflicted & io.ri
  val area_clk = new ClockingArea(ClockDomain(io.CK)) {
    val sel = RegNext(conflicted)
    val d = RegNext(io.D)
    io.qo := sel ? d | io.qi
  }
}


case class Ram2Block(width: Int, depth: Int, async: Boolean = false) extends Ram2(width, depth, async) {

  setDefinitionName(s"${fname}_${width}_${depth}")

  val clka = ClockDomain(if (async) io.CKA else io.CK)
  val clkb = ClockDomain(if (async) io.CKB else io.CK)
  clka.setSynchronousWith(clkb)

  val mem = Mem(UInt(width bits), depth)
  mem.addAttribute("ram_style", "auto")

  val area_clka = new ClockingArea(clka) {
    when(io.W) {
      mem(io.AA) := io.D
    }
  }

  val area_clkb = new ClockingArea(clkb) {
      io.Q := RegNextWhen(mem(io.AB), io.E)
  }

}


case class Ram2CF(width: Int, depth: Int) extends Ram2(width, depth, false) {

  setDefinitionName(s"Ram2CF_${width}_${depth}")

  val cf = RamConflictR(width, depth)
  cf.io.CK <> io.CK
  cf.io.W  <> io.W
  cf.io.D  <> io.D
  cf.io.AA <> io.AA
  cf.io.AB <> io.AB
  cf.io.ri <> io.E
  cf.io.qo <> io.Q

  val mem = Ram2Block(width, depth, false)
  mem.io.CK <> io.CK
  mem.Write(io.W, io.AA, io.D)
  cf.io.qi := mem.Read (cf.io.ro, io.AB)

}


case class Ram2Stream(
        width: Int,
        depth: Int,
        userWidth: Int = 0,
        async: Boolean = false,
        conflict: Boolean = true) extends Component {

  require(if (async) !conflict else true)
  val  addrWidth = log2Up(depth)

  case class PayloadType(a: Boolean=false, d: Boolean=false, u: Boolean=false) extends Bundle {
    val addr = a generate UInt(addrWidth bits)
    val data = d generate UInt(width bits)
    val user = u generate UInt(userWidth bits)
  }

  val io = new Bundle {
    val W  = slave  Flow   (PayloadType(a=true, d=true))
    val Ri = slave  Stream (PayloadType(a=true, u=true))
    val Ro = master Stream (PayloadType(d=true, u=true))

    val CK  = !async generate (in Bool())
    val CKA =  async generate (in Bool())
    val CKB =  async generate (in Bool())
  }
  noIoPrefix()

  var isCF = ""
  val mem: Ram2 = if (conflict) {
    val t = Ram2CF(width, depth)
    isCF = "CF"
    t.io.CK <> io.CK
    t
  } else {
    val t = Ram2Block(width, depth, async)
    if (async) {
      t.io.CKA <> io.CKA
      t.io.CKB <> io.CKB
    } else {
      t.io.CK  <> io.CK
    }
    t
  }
  setDefinitionName(s"${mem.fname}${isCF}_${width}_${depth}_${userWidth}")

  mem.Write(io.W.valid, io.W.payload.addr, io.W.payload.data )
  mem.Read (io.Ri.fire, io.Ri.payload.addr )

  val p = RamPipe(userWidth)
  if (async) {
    p.io.CK <> io.CKB
  } else {
    p.io.CK <> io.CK
  }
  io.Ri.ready <> p.io.S.ready
  io.Ri.valid <> p.io.S.valid
  io.Ro.ready <> p.io.M.ready
  io.Ro.valid <> p.io.M.valid

  io.Ri.payload.user <> p.io.S.payload
  io.Ro.payload.data <> mem.io.Q
  io.Ro.payload.user <> p.io.M.payload

}


// True Dual-Port
case class Ram3(width: Int, depth: Int, clk_a: ClockDomain = null, clk_b: ClockDomain = null) extends Component {
  val io = new Bundle {
    val EA, EB = in Bool()
    val WA, WB = in Bool()
    val AA, AB = in UInt (log2Up(depth) bits)
    val DA, DB = in UInt(width bits)
    val QA, QB = out UInt(width bits)
  }

  noIoPrefix()
  setDefinitionName(s"P3Ram_${width}_${depth}")

  val mem = Mem(UInt(width bits), depth)
  mem.addAttribute("ram_style", "auto")

  val CKA = if (clk_a == null) {
    ClockDomain(ClockDomain.current.readClockWire)
  } else {
    clk_a
  }

  val CKB = if (clk_b == null) {
    ClockDomain(ClockDomain.current.readClockWire)
  } else {
    clk_b
  }
  CKB.setSynchronousWith(CKA)

  val area_clka = new ClockingArea(CKA) {
    when(io.WA & io.EA) {
      mem(io.AA) := io.DA
    }

    val rea = (~io.WA & io.EA)
    io.QA := RegNextWhen(mem(io.AA), rea)
  }

  val area_clkb = new ClockingArea(CKB) {
    when(io.WB & io.EB) {
      mem(io.AB) := io.DB
    }

    val reb = (~io.WB & io.EB)
    io.QB := RegNextWhen(mem(io.AB), reb)
  }
}


*/


case class RamRead(dataWidth : Int, regOut: Boolean = false) extends Component {

  val io = new Bundle {
    val data = in UInt(dataWidth bits)
    val ren  = in  Bool()  // memory read enable
    val nxa  = out Bool()  // next address ready
    val M = master Stream(UInt(dataWidth bits))
  }
  noIoPrefix()
  setDefinitionName(s"RamRead_${dataWidth}")

  val valid = RegNextWhen(io.ren, io.nxa) init False

  if (regOut) {
    val p = RamRegout(dataWidth)
    io.M <> p.io.M
    io.nxa := ~p.io.S.valid | p.io.S.ready
    p.io.S.valid := valid
    p.io.S.payload := io.data
  } else {
    io.nxa := ~io.M.valid | io.M.ready
    io.M.valid := valid
    io.M.payload := io.data
  }
}


case class RamRegout(dataWidth : Int) extends Component {

  val io = new Bundle {
    val S = slave(Stream(UInt(dataWidth bits)))
    val M = master(Stream(UInt(dataWidth bits)))
  }
  noIoPrefix()
  setDefinitionName(s"RamRegout_${dataWidth}")

  val payload_dly = RegNext(io.S.payload)
  val fire_dly = RegNext(io.S.fire, False)
  io.S.ready := io.M.ready || (!io.M.valid)

  val jammed = fire_dly & (!io.M.ready)  // being valid && NOT ready at down-stream boundary
  val payload_hold = RegNextWhen(payload_dly, jammed)

  val valid_hold = Reg(Bool()) init(False)
  when (io.M.ready) {
    valid_hold.clear()
  } elsewhen (jammed) {
    valid_hold.set()
  }

  io.M.valid := valid_hold || fire_dly
  io.M.payload := Mux(valid_hold, payload_hold, payload_dly)

}


//case class FifoRead(addrWidth : Int, dataWidth : Int, regout : Boolean=false) extends Component {
case class FifoRead(depth : Int, dataWidth : Int, clk : ClockDomain = ClockDomain.current, regOut: Boolean = false) extends Component {

  val addrWidth = log2Up(depth)
  val ptWidth = addrWidth + 1
  val usedWidth = log2Up(depth + 1)

  val io = new Bundle {
    val wpt = in UInt(ptWidth bits)
    val rpt = out UInt(ptWidth bits)
    val rAddr = out UInt(addrWidth bits)
    val rData = in UInt(dataWidth bits)
    val ren = out Bool()
    val empty = out Bool()
    val rused  = out UInt(usedWidth bits)
    val M = master Stream(UInt(dataWidth bits))
  }
  noIoPrefix()
  setDefinitionName(s"FifoRead_${depth}_${dataWidth}")

  val clockArea = clk on {
    val pipe = RamRead(dataWidth, regOut)
    io.M << pipe.io.M
    io.ren := ~io.empty & pipe.io.nxa
    pipe.io.data := io.rData
    pipe.io.ren := io.ren

    io.rused := Mux(io.wpt >= io.rpt, io.wpt - io.rpt, io.wpt + depth * 2 - io.rpt).resize(usedWidth)
    io.empty := (io.rused === io.rused.getZero)
    io.rAddr := Mux(io.rpt < depth, io.rpt, io.rpt - depth).resize(addrWidth)

    io.rpt := Counter(depth * 2, io.ren)
  }
}

case class FifoWrite(depth : Int, dataWidth : Int, clk : ClockDomain = ClockDomain.current) extends Component {

  val addrWidth = log2Up(depth)
  val ptWidth = addrWidth + 1
  val usedWidth = log2Up(depth + 1)

  val io = new Bundle {
    val wpt = out UInt(ptWidth bits)
    val rpt = in UInt(ptWidth bits)
    val wAddr = out UInt(addrWidth bits)
    val wData = out UInt(dataWidth bits)
    val wen = out Bool()
    val full = out Bool()
    val wused  = out UInt(usedWidth bits)
    val S = slave Stream(UInt(dataWidth bits))
  }
  noIoPrefix()
  setDefinitionName(s"FifoWrite_${depth}_${dataWidth}")

  val clockArea = clk on {
    io.wData := io.S.payload
    io.wen := ~io.full & io.S.valid

    io.wused := Mux(io.wpt >= io.rpt, io.wpt - io.rpt, io.wpt + depth * 2 - io.rpt).resize(usedWidth)
    //  io.wAddr := io.wpt(0, addrWidth bits)
    io.wAddr := Mux(io.wpt < depth, io.wpt, io.wpt - depth).resize(addrWidth)
    //  io.full := (io.wAddr === rAddr) & (io.wpt.msb =/= io.rpt.msb)
    io.full := (io.wused === depth)
    io.S.ready := ~io.full

    io.wpt := Counter(depth * 2, io.wen)
  }
}


case class Fifo (
    depth : Int,
    dataWidth : Int,
    clkA : ClockDomain = ClockDomain.current,
    clkB : ClockDomain = ClockDomain.current,
    regOut: Boolean = false,
    cdcDepth: Int = 1)
  extends Component {

  val addrWidth = log2Up(depth)
  val ptWidth = addrWidth + 1
  val async = (clkA != clkB)
  val usedWidth = log2Up(depth + 1)

  clkB.setSyncWith(clkA)

  val io = new Bundle {
//    val full = out Bool()
    val wused  = out UInt(usedWidth bits)
    val S = slave Stream(UInt(dataWidth bits))

//    val empty = out Bool()
    val rused  = out UInt(usedWidth bits)
    val M = master Stream(UInt(dataWidth bits))
  }
  noIoPrefix()
  setDefinitionName(s"Fifo_${depth}_${dataWidth}")

  val wSide =  FifoWrite(depth, dataWidth, clkA)
  val rSide =  FifoRead (depth, dataWidth, clkB, regOut)
  if (async) {
    val a2b = CdcRing(clkA, clkB, ptWidth, cdcDepth)
    val b2a = CdcRing(clkB, clkA, ptWidth, cdcDepth)
    wSide.io.wpt <> a2b.io.D
    a2b.io.Q <> rSide.io.wpt
    rSide.io.rpt <> b2a.io.D
    b2a.io.Q <> wSide.io.rpt
  } else {
    wSide.io.wpt <> rSide.io.wpt
    wSide.io.rpt <> rSide.io.rpt
  }

//  io.full  <> wSide.io.full
  io.wused <> wSide.io.wused
  io.S <> wSide.io.S

//  io.empty <> rSide.io.empty
  io.rused <> rSide.io.rused
  io.M <> rSide.io.M

  val mem =  Ram2(depth, dataWidth, clkA, clkB)

  mem.Write(wSide.io.wen, wSide.io.wAddr, wSide.io.wData)
  rSide.io.rData := mem.Read (rSide.io.ren, rSide.io.rAddr)

}


case class Pipe(width: Int, mode : Int = 1) extends Component {

  val S = slave  Stream(UInt(width bits))
  val M = master Stream(UInt(width bits))

  setDefinitionName(s"Pipe${mode}_${width}")

  mode match {
    case 0 => M <<   S
    case 1 => M <-<  S
    case 2 => M </<  S
    case 3 => M <-/< S
    case _ => println(s"##Error@Pipe : mode = ${mode} is out of range.")
  }
}


object MemoryVerilog extends App {
//  Config.spinal.generateVerilog(Ram1 (8, 16) )
//  Config.spinal.generateVerilog(Ram2(8, 16, false) )
//  Config.spinal.generateVerilog(Ram2S(8, 16) )
//  Config.spinal.generateVerilog(RamRead(8, true) )
//  Config.spinal.generateVerilog(RamPipe(8) )
//  Config.spinal.generateVerilog(FifoRead (8) )

    Config.spinal.generateVerilog(Fifo(20, 8, ClockDomain.external("a"), ClockDomain.external("b"), true) )
//    Config.spinal.generateVerilog(Fifo(20, 8) )
}

