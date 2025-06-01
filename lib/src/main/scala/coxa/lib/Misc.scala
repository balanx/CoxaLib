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

object MiscVerilog extends App {
  Config.spinal.generateVerilog(Pipe(8) )
}

