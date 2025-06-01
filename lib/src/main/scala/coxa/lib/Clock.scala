// https://github.com/balanx/Coxalib

package coxa.lib


import spinal.core.{UInt, _}
import spinal.lib._

class Clock (async : Boolean = true) extends Component {
//  val dual = true

//  val CK , RST  = !dual generate(in Bool())
  val CKA, RSTA =  async generate(in Bool())
  val CKB, RSTB =  async generate(in Bool())

  val clkA = if (async) ClockDomain(CKA, RSTA) else ClockDomain.current
  val clkB = if (async) ClockDomain(CKB, RSTB) else ClockDomain.current

  def clkConnecting(A: ClockDomain, B: ClockDomain) = {
    CKA <> A.readClockWire
    RSTA <> A.readResetWire
    CKB <> B.readClockWire
    RSTB <> B.readResetWire
    this
  }

//  def clkConnecting (A : ClockDomain) = {
//    CK   <> A.readClockWire
//    RST  <> A.readResetWire
//    this
//  }

}


//
// A_di -> B_dj -> B_dk
//
class CdcSingle (cdcDepth: Int = 1) extends Clock {

  assert(cdcDepth >= 1)

  val io = new Bundle {
//    val CKA, RSTA = in  Bool()
//    val CKB, RSTB = in  Bool()
    val D = in  Bool()
    val Q = out Bool()
  }


  noIoPrefix()
  setDefinitionName(s"CdcSingle_c${cdcDepth}")

//  val clkA = ClockDomain(io.CKA, io.RSTA)
//  val clkB = ClockDomain(io.CKB, io.RSTB)

  val A = new ClockingArea(clkA) {
    val di = RegNext(io.D) init False
  }

  val B = new ClockingArea(clkB) {
    val dj = RegNext(A.di) init (False) addTag(crossClockDomain)

    val dk = Reg(UInt(cdcDepth bits)) init(0)
    dk := (dk ## dj).resize(cdcDepth).asUInt
    io.Q := dk(cdcDepth -1)
  }
}

object CdcSingle {
  def apply(clkA : ClockDomain, clkB : ClockDomain, cdcDepth: Int = 1) = {
    val e = new CdcSingle(cdcDepth)
//    e.io.CKA  <> clkA.readClockWire
//    e.io.RSTA <> clkA.readResetWire
//    e.io.CKB  <> clkB.readClockWire
//    e.io.RSTB <> clkB.readResetWire
    e.clkConnecting(clkA, clkB)
    e
  }
}

//
// assign B_y = (B_x ^ cdc_Q);
// if(B_y) B_dj <= A_di;
//
class CdcFlip (dataWidth : Int, ring : Boolean = false, cdcDepth : Int = 1) extends Clock {

  assert(cdcDepth >= 1)

  val io = new Bundle {
//    val CKA, RSTA = in  Bool()
//    val CKB, RSTB = in  Bool()
    val fa = in  Bool() // flip at clkA
    val fb = out Bool() // flip at clkB
    val D  = in  UInt(dataWidth bits)
    val Q  = out UInt(dataWidth bits)
  }

  noIoPrefix()
  setDefinitionName(s"CdcFlip_c${cdcDepth}_w${dataWidth}" + "_r" + (if(ring) "1" else "0") )

//  val clkA = ClockDomain(io.CKA, io.RSTA)
//  val clkB = ClockDomain(io.CKB, io.RSTB)
val cdc = CdcSingle(clkA, clkB, cdcDepth)
  io.fb := cdc.io.Q

  val A = new ClockingArea(clkA) {
    val x = Reg(Bool()) init False
    val y = (x === io.fa)
    if (ring)
      when(y) { x :=  ~x }
    else
      x := io.fa

    cdc.io.D := Mux(y, ~x, x)
    val di = RegNextWhen(io.D, y) init 0
  }

  val B = new ClockingArea(clkB) {
    val x = RegNext(cdc.io.Q) init False
    val y = x ^ cdc.io.Q
    val dj = RegNextWhen(A.di, y) init(0) addTag(crossClockDomain)
    io.Q := dj
  }

}

object CdcFlip {
  def apply(clkA : ClockDomain, clkB : ClockDomain, dataWidth : Int, ring : Boolean = false, cdcDepth: Int = 1) = {
    val e = new CdcFlip(dataWidth, ring, cdcDepth)
//    e.io.CKA  <> clkA.readClockWire
//    e.io.RSTA <> clkA.readResetWire
//    e.io.CKB  <> clkB.readClockWire
//    e.io.RSTB <> clkB.readResetWire
    e.clkConnecting(clkA, clkB)
    e
  }
}

//
class CdcRing (dataWidth : Int, cdcDepth: Int = 1) extends Clock {

  assert(cdcDepth >= 1)

  val io = new Bundle {
//    val CKA, RSTA = in  Bool()
//    val CKB, RSTB = in  Bool()
    val D  = in  UInt(dataWidth bits)
    val Q  = out UInt(dataWidth bits)
  }

  noIoPrefix()
  setDefinitionName(s"CdcRing_c${cdcDepth}_w${dataWidth}")

//  val clkA = ClockDomain(io.CKA, io.RSTA)
//  val clkB = ClockDomain(io.CKB, io.RSTB)

  val a2b = CdcFlip(clkA, clkB, dataWidth, ring = true, cdcDepth)
  io.D <> a2b.io.D
  io.Q <> a2b.io.Q
  val fb = a2b.io.fb

  val b2a = CdcSingle(clkB, clkA, cdcDepth)
  fb <> b2a.io.D
  val fa = b2a.io.Q
  fa <> a2b.io.fa

}

object CdcRing {
  def apply(clkA : ClockDomain, clkB : ClockDomain, dataWidth : Int, cdcDepth: Int = 1) = {
    val e = new CdcRing(dataWidth, cdcDepth)
//    e.io.CKA  <> clkA.readClockWire
//    e.io.RSTA <> clkA.readResetWire
//    e.io.CKB  <> clkB.readClockWire
//    e.io.RSTB <> clkB.readResetWire
    e.clkConnecting(clkA, clkB)
    e
  }
}


object ClockVerilog extends App {
//  Config.spinal.generateVerilog(new CdcSingle(2) )
//  Config.spinal.generateVerilog(new CdcFlip  (8) )
  Config.spinal.generateVerilog(new CdcRing  (8) )
//  Config.spinal.generateVerilog(new Test() )
}

