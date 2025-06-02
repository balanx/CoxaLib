// https://github.com/balanx/Coxalib

package coxa.lib

//import scala.language.postfixOps
import spinal.core.{UInt, _}
import spinal.lib._

//
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


/*
// For father class Clock()
//
class Test () extends Clock {
  override val dual = false

  val io = new Bundle {
    val D = in Bool()
    val Q = out Bool()
  }

  val A = new ClockingArea(clkA) {
    val di = RegNext(io.D) init False
  }

  val B = new ClockingArea(clkB) {
    val dj = RegNext(A.di) init (False) addTag (crossClockDomain)
  }

  io.Q := B.dj
}
*/

/*
// For normalizeComponentClockDomainName = true
//
case class Sub() extends Component {

  val io = new Bundle {
    val din = in UInt (8 bits)
    val dout = out UInt (8 bits)
  }

//  val aClock = new ClockingArea(clk) {
    io.dout := RegNext(io.din)
//  }
}


case class Test() extends Component {

  val io = new Bundle {
    val din = in UInt(8 bits)
    val dout = out UInt(8 bits)
  }

  val clkA = ClockDomain.external("a")
  val clkB = ClockDomain.external("b")
  clkA.setSyncWith(clkB)
  val A = new ClockingArea(clkA) {
    val u0 = Sub()
    u0.io.din <> io.din
  }
  val B = new ClockingArea(clkB) {
    val u1 = Sub()
    u1.io.dout <> io.dout
  }
  A.u0.io.dout <> B.u1.io.din
}


case class Sub(clk: ClockDomain) extends Component {

  val io = new Bundle {
    val din = in UInt (8 bits)
    val dout = out UInt (8 bits)
  }

  val aClock = new ClockingArea(clk) {
    io.dout := RegNext(io.din)
  }
}
*/

/*
// ClockDomain.current is NOT smarter.

case class clkDemo() extends Component {

  val io = new Bundle {
    val CKA, CKB = in Bool()
    val din = in UInt(8 bits)
    val dout = out UInt(8 bits)
  }

  val data = UInt(8 bits)

  val aClock = ClockDomain(io.CKA)
  val a = aClock on {
    data := RegNext(io.din)
  }

  val bClock = ClockDomain(io.CKB)
  val b = bClock on {
    io.dout := RegNext(data)
  }
  bClock.setSyncWith(aClock)

}


case class Test() extends Component {

  val io = new Bundle {
    val din = in UInt(8 bits)
    val dout = out UInt(8 bits)
  }

  val demo = clkDemo()
  demo.io.CKA := ClockDomain.current.readClockWire
  demo.io.CKB := ClockDomain.current.readClockWire

  val d, q = UInt(8 bits)

  d := RegNext(io.din)
  demo.io.din <> d
  demo.io.dout <> q
  io.dout := RegNext(q)

}
*/

object MiscVerilog extends App {
//  Config.spinal.generateVerilog(Pipe(8) )
//  Config.spinal.generateVerilog(Test( ) )
}

