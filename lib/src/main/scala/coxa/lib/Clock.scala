// https://github.com/balanx/Coxalib

package coxa.lib


import spinal.core.{UInt, _}
import spinal.lib._

//
// A_di -> B_dj -> B_dk
//
case class CdcSingle (
    clkA : ClockDomain,
    clkB : ClockDomain,
    cdcDepth: Int = 1)
  extends Component {

  assert(cdcDepth >= 1)

  val io = new Bundle {
    val D = in  Bool()
    val Q = out Bool()
  }

  noIoPrefix()
  setDefinitionName(s"CdcSingle_${cdcDepth}", false)

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

//
// assign B_y = (B_x ^ cdc_Q);
// if(B_y) B_dj <= A_di;
//
case class CdcFlip (
    clkA : ClockDomain,
    clkB : ClockDomain,
    dataWidth : Int,
    cdcDepth: Int = 1)
  extends Component {

  assert(cdcDepth >= 1)

  val io = new Bundle {
    val fa = in  Bool() // flip at clkA
    val fb = out Bool() // flip at clkB
    val D  = in  UInt(dataWidth bits)
    val Q  = out UInt(dataWidth bits)
  }

  noIoPrefix()
  setDefinitionName(s"CdcFlip_${cdcDepth}_${dataWidth}", false)

  val cdc = CdcSingle(clkA, clkB, cdcDepth)
  io.fa <> cdc.io.D
  io.fb <> cdc.io.Q

  val A = new ClockingArea(clkA) {
    val di = RegNext(io.D) init 0
  }

  val B = new ClockingArea(clkB) {
    val x = RegNext(cdc.io.Q) init False
    val y = x ^ cdc.io.Q
    val dj = RegNextWhen(A.di, y) init(0) addTag(crossClockDomain)
    io.Q := dj
  }
}


//
case class CdcRing (
    clkA : ClockDomain,
    clkB : ClockDomain,
    dataWidth : Int,
    cdcDepth: Int = 1)
  extends Component {

  assert(cdcDepth >= 1)

  val io = new Bundle {
    val D  = in  UInt(dataWidth bits)
    val Q  = out UInt(dataWidth bits)
  }

  noIoPrefix()
  setDefinitionName(s"CdcRing_${cdcDepth}_${dataWidth}", false)

  val a2b = CdcFlip(clkA, clkB, dataWidth, cdcDepth)
  io.D <> a2b.io.D
  io.Q <> a2b.io.Q
  val fb = a2b.io.fb

  val b2a = CdcSingle(clkB, clkA, cdcDepth)
  fb <> b2a.io.D
  val fa = b2a.io.Q
  fa <> a2b.io.fa

}


object ClockVerilog extends App {
//  Config.spinal.generateVerilog(CdcSingle(ClockDomain.external("a"), ClockDomain.external("b"),2) )
//  Config.spinal.generateVerilog(CdcFlip  (ClockDomain.external("a"), ClockDomain.external("b"),8) )
  Config.spinal.generateVerilog(CdcRing  (ClockDomain.external("a"), ClockDomain.external("b"),8) )
}

