// https://github.com/balanx/Coxalib

package coxa.lib

//import scala.language.postfixOps
import spinal.core.{UInt, _}
import spinal.lib._

// Single-Port
case class Ram1(width: Int, depth: Int) extends Component {
  val io = new Bundle {
    val E = in Bool()
    val W = in Bool()
    val A = in UInt (log2Up(depth) bits)
    val D = in UInt(width bits)
    val Q = out UInt(width bits)

    val CK =  in Bool()
  }

  noIoPrefix()
  setDefinitionName(s"Ram1_${width}_${depth}")

  val mem = Mem(UInt(width bits), depth)
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
case class Ram2A(width: Int, depth: Int) extends Component {

  val io = new Bundle {
    val E = in Bool()
    val W = in Bool()
    val AA, AB = in UInt (log2Up(depth) bits)
    val D = in UInt (width bits)
    val Q = out UInt (width bits)

    val CKA =  in Bool()
    val CKB =  in Bool()
  }

  noIoPrefix()
  setDefinitionName(s"Ram2A_${width}_${depth}")

  val mem = Mem(UInt(width bits), depth)
  mem.addAttribute("ram_style", "auto")

  val wen = ( io.W & io.E)
  val ren = (~io.W & io.E)
  //ClockDomain(ClockDomain.current.readClockWire)
  val clk_a = ClockDomain(io.CKA)
  val clk_b = ClockDomain(io.CKB)
  clk_b.setSynchronousWith(clk_a)

  val area_clka = new ClockingArea(clk_a) {
    when(wen) {
      mem(io.AA) := io.D
    }
  }

  val area_clkb = new ClockingArea(clk_b) {
    io.Q := RegNextWhen(mem(io.AB), ren)
  }


  def Write(enable: Bool, address: UInt, data: UInt): Unit = {
    io.W := enable
    io.AA := address
    io.D := data
  }

  def Read(enable: Bool, address: UInt): UInt = {
    io.E := enable
    io.AB := address
    io.Q
  }

  //  if (depth < (1 << io.AA.getWidth)) {
  //    assert(io.AA >= depth, (L"AA(=${io.AA}) greater than or equal to depth") + s"(=$depth)")
  //    assert(io.AB >= depth, L"AB(=${io.AB}) greater than or equal to depth")
  //  }

}


case class Ram2S(width: Int, depth: Int) extends Component {

  val io = new Bundle {
    val E = in Bool()
    val W = in Bool()
    val AA, AB = in UInt (log2Up(depth) bits)
    val D = in UInt (width bits)
    val Q = out UInt (width bits)

     val CK =  in Bool()
  }

  noIoPrefix()
  setDefinitionName(s"Ram2S_${width}_${depth}")

  val mem = Mem(UInt(width bits), depth)
  mem.addAttribute("ram_style", "auto")

  val wen = ( io.W & io.E)
  val ren = (~io.W & io.E)
  //ClockDomain(ClockDomain.current.readClockWire)
  val clk = ClockDomain(io.CK)

  val area_clk = new ClockingArea(clk) {
    when(wen) {
      mem(io.AA) := io.D
    }

    io.Q := RegNextWhen(mem(io.AB), ren)
  }


  def Write(enable: Bool, address: UInt, data: UInt): Unit = {
    io.W := enable
    io.AA := address
    io.D := data
  }

  def Read(enable: Bool, address: UInt): UInt = {
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


// io.M <-< io.S
case class RamPipe(width : Int) extends Component {

  val io = new Bundle {
    val CK = in Bool()
    val S = slave Stream (UInt(width bits))
    val M = master Stream (UInt(width bits))
  }
  noIoPrefix()
  setDefinitionName(s"RamPipe_${width}")

  val area_clk = new ClockingArea(ClockDomain(io.CK)) {
    io.S.ready := ~io.M.valid | io.M.ready
    io.M.valid := RegNextWhen(io.S.valid, io.S.ready)
    io.M.payload := RegNextWhen(io.S.payload, io.S.ready)
  }
}
*/


case class RamRead(width : Int) extends Component {

  val io = new Bundle {
    val data = in UInt(width bits)
    val ren  = in  Bool()  // read enable
    val nxa  = out Bool()  // next address
    val M = master Stream(UInt(width bits))
  }
  noIoPrefix()
  setDefinitionName(s"RamStream_${width}")

  io.nxa  := ~io.M.valid | io.M.ready
  io.M.valid := RegNextWhen(io.ren, io.nxa) init False
  io.M.payload := io.data

}


case class RamPipe(width : Int) extends Component {

  val io = new Bundle {
    val S = slave(Stream(UInt(width bits)))
    val M = master(Stream(UInt(width bits)))
  }
  noIoPrefix()
  setDefinitionName(s"RamPipe_${width}")

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
case class FifoRead(addrWidth : Int) extends Component {

  val width = addrWidth + 1

  val io = new Bundle {
    val wpt = in UInt(width bits)
    val empty = out Bool()
    val rused  = out UInt(width bits)
//    val R = master Stream(UInt(width bits))
  }
  noIoPrefix()
//  val Fname = if (regout) "FifoReadReg" else "FifoRead"
//  setDefinitionName(s"${Fname}_${addrWidth}_${dataWidth}")
  setDefinitionName(s"FifoRead_${addrWidth}")


  val rpt = Reg(UInt(width bits)) init 0
  rpt := rpt + 1

  io.empty := (io.wpt === rpt)
  io.rused := (io.wpt  -  rpt)


}




case class Pipe(mode: Int, width : Int) extends Component {

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


object MemoryGen extends App {
//  Config.spinal.generateVerilog(Ram1 (8, 16) )
//  Config.spinal.generateVerilog(Ram2A(8, 16) )
//  Config.spinal.generateVerilog(Ram2S(8, 16) )
  Config.spinal.generateVerilog(RamRead(8) )
  Config.spinal.generateVerilog(RamPipe(8) )
//  Config.spinal.generateVerilog(FifoRead (8) )
}

