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
  setDefinitionName(s"Ram1_h${depth}_w${dataWidth}")

  val mem = Mem(UInt(dataWidth bits), depth)
  mem.addAttribute("ram_style", "auto")

  val wen = ( io.W & io.E)
  val ren = (~io.W & io.E)

  val clk = ClockDomain(io.CK)
  val area_clk = new ClockingArea(clk) {
    when(wen) { mem(io.A) := io.D }

    io.Q := RegNextWhen(mem(io.A), ren)
  }

}


// Simple Dual-Port
class Ram2(depth: Int, dataWidth: Int, async: Boolean = false) extends Component {

  val addrWidth = log2Up(depth)
//  val async = (clkA != clkB)

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
  setDefinitionName("Ram2" + (if (async) "A" else "S")
                    + s"_h${depth}_w${dataWidth}")

//  val wen =  io.W & io.E
//  val ren = ~io.W & io.E
  val wen = io.W
  val ren = io.E

  val clkA = ClockDomain(if (async) io.CKA else io.CK)
  val clkB = ClockDomain(if (async) io.CKB else io.CK)
  clkB.setSyncWith(clkA)
//  clkA.setSyncWith(aClk)
//  clkB.setSyncWith(bClk)

  val data = UInt (dataWidth bits)

  val areaA = new ClockingArea(clkA) {
    val mem = Mem(UInt(dataWidth bits), depth)
    mem.addAttribute("ram_style", "auto")

    when(wen) {
      mem(io.AA) := io.D
    }
    data := mem(io.AB)
  }

  val areaB = new ClockingArea(clkB) {
    io.Q := RegNextWhen(data, ren)
  }

  def Write(enable: Bool, address: UInt, data: UInt): Unit = {
//    if (async) io.CKA := clkA.readClockWire else io.CK := clkA.readClockWire

    io.W := enable
    io.AA := address
    io.D := data
  }

  def Read(enable: Bool, address: UInt): UInt = {
//    if (async) io.CKB := clkB.readClockWire //else io.CK := clkB.readClockWire

    io.E := enable
    io.AB := address
    io.Q
  }

  //  if (depth < (1 << io.AA.getWidth)) {
  //    assert(io.AA >= depth, (L"AA(=${io.AA}) greater than or equal to depth") + s"(=$depth)")
  //    assert(io.AB >= depth, L"AB(=${io.AB}) greater than or equal to depth")
  //  }

}


object Ram2 {
  def apply(clkA : ClockDomain, clkB : ClockDomain, depth : Int, dataWidth : Int) = {
    val e = new Ram2(depth, dataWidth, async = true)
    e.io.CKA  <> clkA.readClockWire
    e.io.CKB  <> clkB.readClockWire
    e
  }

  def apply(depth : Int, dataWidth : Int) = {
    val e = new Ram2(depth, dataWidth, async = false)
    e.io.CK  <> ClockDomain.current.readClockWire
    e.clkA.setSyncWith(ClockDomain.current)
    e.clkB.setSyncWith(ClockDomain.current)
    e
  }

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
  setDefinitionName(s"RamRead" + "_r" + (if(regOut) "1" else "0") + s"_w${dataWidth}" )

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
  setDefinitionName(s"RamRegout_w${dataWidth}")

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


case class FifoRead(depth : Int, dataWidth : Int, regOut: Boolean = false) extends Component {

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
  setDefinitionName(s"FifoRead" + "_r" + (if(regOut) "1" else "0") + s"_h${depth}_w${dataWidth}" )

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

case class FifoWrite(depth : Int, dataWidth : Int) extends Component {

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
  setDefinitionName(s"FifoWrite_h${depth}_w${dataWidth}")

  io.wData := io.S.payload
  io.wen := ~io.full & io.S.valid

  io.wused := Mux(io.wpt >= io.rpt, io.wpt - io.rpt, io.wpt + depth * 2 - io.rpt).resize(usedWidth)
  io.wAddr := Mux(io.wpt < depth, io.wpt, io.wpt - depth).resize(addrWidth)
  io.full := (io.wused === depth)
  io.S.ready := ~io.full

  io.wpt := Counter(depth * 2, io.wen)

}


class Fifo (
    depth : Int,
    dataWidth : Int,
    async : Boolean = false,
    regOut: Boolean = false,
    cdcDepth: Int = 1)
  extends Clock(async) {

//  override val dual = async

  val addrWidth = log2Up(depth)
  val ptWidth = addrWidth + 1
//  val async = (clkA != clkB)
  val usedWidth = log2Up(depth + 1)


  val io = new Bundle {
//    val CKA, RSTA = in  Bool()
//    val CKB, RSTB = in  Bool()
//    val full = out Bool()
    val wused  = out UInt(usedWidth bits)
    val S = slave Stream(UInt(dataWidth bits))

//    val empty = out Bool()
    val rused  = out UInt(usedWidth bits)
    val M = master Stream(UInt(dataWidth bits))
  }
  noIoPrefix()
  setDefinitionName("Fifo" + (if(async) "A" else "S")
                    + s"_c${cdcDepth}"
                    + "_r" + (if(regOut) "1" else "0")
                    + s"_h${depth}_w${dataWidth}" )

//  val clkA = ClockDomain(io.CKA, io.RSTA)
//  val clkB = ClockDomain(io.CKB, io.RSTB)
//  clkB.setSyncWith(clkA)

  val A = new ClockingArea(clkA) {
    val w = FifoWrite(depth, dataWidth)
  }
  val B = new ClockingArea(clkB) {
    val r = FifoRead(depth, dataWidth, regOut)
  }

  if (async) {
    val a2b = CdcRing(clkA, clkB, ptWidth, cdcDepth)
    val b2a = CdcRing(clkB, clkA, ptWidth, cdcDepth)
    A.w.io.wpt <> a2b.io.D
    a2b.io.Q <> B.r.io.wpt
    B.r.io.rpt <> b2a.io.D
    b2a.io.Q <> A.w.io.rpt
  } else {
    A.w.io.wpt <> B.r.io.wpt
    A.w.io.rpt <> B.r.io.rpt
  }

//  io.full  <> wSide.io.full
  io.wused <> A.w.io.wused
  io.S <> A.w.io.S

//  io.empty <> rSide.io.empty
  io.rused <> B.r.io.rused
  io.M <> B.r.io.M

  val mem = if (async) Ram2(clkA, clkB, depth, dataWidth) else Ram2(depth, dataWidth)
  mem.Write(A.w.io.wen, A.w.io.wAddr, A.w.io.wData)
  B.r.io.rData := mem.Read (B.r.io.ren, B.r.io.rAddr)

}

object Fifo {
  def apply(clkA : ClockDomain, clkB : ClockDomain, depth : Int, dataWidth : Int, regOut: Boolean = false, cdcDepth: Int = 1) = {
    val e = new Fifo(depth, dataWidth, async = true, regOut, cdcDepth)
//    e.io.CKA  <> clkA.readClockWire
//    e.io.RSTA <> clkA.readResetWire
//    e.io.CKB  <> clkB.readClockWire
//    e.io.RSTB <> clkB.readResetWire
    e.clkConnecting(clkA, clkB)
    e
  }
}


object MemoryVerilog extends App {
//  Config.spinal.generateVerilog(Ram1 (16, 8) )
//  Config.spinal.generateVerilog(Ram2(8, 16, false) )
//  Config.spinal.generateVerilog(Ram2S(8, 16) )
//  Config.spinal.generateVerilog(RamRead(8, true) )
//  Config.spinal.generateVerilog(RamPipe(8) )
//  Config.spinal.generateVerilog(FifoRead (8) )

  Config.spinal.generateVerilog(new Fifo(20, 8, regOut = true, cdcDepth = 2) )
  Config.spinal.generateVerilog(new Fifo(20, 8, async = true) )
}

