// https://github.com/balanx/Coxalib

package coxa.lib

//import scala.language.postfixOps
import spinal.core.{UInt, _}
import spinal.lib._

/*
object Bin2hot {
  def apply(value: UInt, hotWidth: Int): UInt = {
    if (hotWidth <= 0) U(0, hotWidth bits)
    else U(1, hotWidth bits) |<< value
  }
  def apply(value : UInt) : UInt = {
    val hotWidth = 1 << widthOf(value)
    apply(value, hotWidth)
  }
}

object Bin2hotMaskLow {
  def apply(value: UInt, hotWidth: Int): UInt = {
    val d =  ~U(0, hotWidth bits)
    if (hotWidth <= 0) d
    else d |>> (hotWidth - value -1)
  }
  def apply(value : UInt) : UInt = {
    val hotWidth = 1 << widthOf(value)
    apply(value, hotWidth)
  }
}
*/

//e.g. m_bin = 1, return Mask=1100
object Bin2hotMaskHigh {
  def apply(value: UInt, hotWidth: Int): UInt = {
    val d =  ~U(0, hotWidth bits)
    if (hotWidth <= 0) d
    else {
      (d |<< value) |<< 1
    }
  }
  def apply(value : UInt) : UInt = {
    val hotWidth = 1 << widthOf(value)
    apply(value, hotWidth)
  }
}


case class Bin2hotTest (binWidth: Int, sel: Int = 0) extends Component {

  val hotWidth = 1 << binWidth

  val io = new Bundle {
    val bin = in UInt (binWidth bits)
    val hot = out UInt (hotWidth bits)
  }

  noIoPrefix()
  setDefinitionName(s"Bin2hotTest_${binWidth}")

  io.hot := Bin2hotMaskHigh(io.bin)
//  if (sel == 1)
//    io.hot := Bin2hotMaskLow(io.bin)
//  else if (sel == 2)
//    io.hot := Bin2hotMaskHigh(io.bin)
//  else
//    io.hot := Bin2hot(io.bin)
}


case class Hot2binLowFirst (binWidth: Int) extends Component {

  val hotWidth = 1 << binWidth

  val io = new Bundle {
    val hot = in  UInt (hotWidth bits)
    val bin = out UInt (binWidth bits)
    val zero = out Bool()
  }

  noIoPrefix()
  setDefinitionName(s"Hot2binLowFirst_${binWidth}")

  switch (True) {
    for(i <- 0 until hotWidth) {
      is(io.hot(i)) {io.bin := i}
    }
    default {
      io.bin := U(0, binWidth bits)
    }
  }
  io.zero := (io.hot === 0)
}


case class Roundrobin (hotWidth: Int, userWidth: Int = 0) extends Component {

  val binWidth = log2Up(hotWidth)

  val io = new Bundle {
    val bin = out UInt (binWidth bits)
    val S = Vec(slave Stream(UInt(userWidth bits)), hotWidth)
    val M = master Stream(UInt(userWidth bits))
  }

  noIoPrefix()
  setDefinitionName(s"Roundrobin_${hotWidth}_${userWidth}")

  //e.g. m_bin = 1
  //mask High = 1100
  //mask Low  = 0011
  val maskHigh =  Bin2hotMaskHigh(io.bin)
  val maskLow  =  ~maskHigh
  maskLow(io.bin) :=  ~io.M.valid // stop 1 cycle

  val req = UInt(hotWidth bits)
  for(i <- 0 until hotWidth) {
    req(i) := io.S(i).valid
    io.S(i).ready := False
  }
  io.S(io.bin).ready := io.M.ready & io.M.valid

  val hotHigh = Hot2binLowFirst(binWidth)
  hotHigh.io.hot := req & maskHigh
  val hotLow  = Hot2binLowFirst(binWidth)
  hotLow.io.hot  := req & maskLow

  val rdy = ~io.M.valid | io.M.ready
  val vld = ~hotHigh.io.zero | ~hotLow.io.zero
  val nx  =  Mux(hotHigh.io.zero, hotLow.io.bin, hotHigh.io.bin)

  io.M.valid := RegNextWhen(vld, rdy) init False
  io.M.payload := RegNextWhen(io.S(nx).payload, rdy & vld) init 0
  io.bin := RegNextWhen(nx, rdy & vld)

}


object ArbiterVerilog extends App {
//  Config.spinal.generateVerilog(Bin2hotTest(3) )
//  Config.spinal.generateVerilog(Hot2binLowFirst(3) )
  Config.spinal.generateVerilog(Roundrobin(8, 3) )
}

