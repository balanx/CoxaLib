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


case class Bin2hotTest (binWidth: Int) extends Component {

  val hotWidth = 1 << binWidth

  val io = new Bundle {
    val bin = in UInt (binWidth bits)
    val hot = out UInt (hotWidth bits)
  }

  noIoPrefix()
  setDefinitionName(s"Bin2hotTest_${binWidth}")

  io.hot := Bin2hotMaskHigh(io.bin)
}
*/

// e.g.
// m_bin = 0, return Mask=1110
// m_bin = 1, return Mask=1100
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


case class Hot2binLowFirst (binWidth: Int) extends Component {

  val hotWidth = 1 << binWidth

  val io = new Bundle {
    val hot = in  UInt (hotWidth bits)
    val bin = out UInt (binWidth bits)
    val zero = out Bool()
  }

  noIoPrefix()
  setDefinitionName(s"Hot2binLowFirst_b${binWidth}")

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

// hotWidth MUST be 2^n
case class Roundrobin (hotWidth: Int, userWidth: Int = 0) extends Component {

  val binWidth = log2Up(hotWidth)

  val io = new Bundle {
    val bin = out UInt (binWidth bits)
    val S = Vec(slave Stream(UInt(userWidth bits)), hotWidth)
    val M = master Stream(UInt(userWidth bits))
  }

  noIoPrefix()
  setDefinitionName(s"Roundrobin_u${userWidth}_h${hotWidth}")

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

// args = Array(a0, a1, a2, ...)
// a0, a1, a2 MUST be 2^n
// rr(a0) -> rr(a1) -> rr(a2)
// a0 is Egress
case class RoundrobinTree (args: Array[Int], userWidth: Int = 0) extends Component {

//  assert(args(i) > 1)
  val leng = args.length
  assert(leng > 1)
  val theLast = leng - 1

  val instNum = args.scanLeft(1)(_*_)
//println("instNum", instNum.mkString(","))
  val hotWidth = instNum.last
  val binWidth = log2Up(hotWidth)
  val uw = args.map(log2Up(_)).scanRight(userWidth)(_+_).drop(1)
//println("uw", uw.mkString(","))

  val io = new Bundle {
    val bin = out UInt (binWidth bits)
    val S = Vec(slave Stream (UInt(userWidth bits)), hotWidth)
    val M = master Stream (UInt(userWidth bits))
  }

  noIoPrefix()
  val fname = args.map("_h" + _.toString).reduce(_ + _)
  setDefinitionName(s"RoundrobinTree_u${userWidth}${fname}")

  var r = Map[(Int, Int), Roundrobin]()
  for (i <- 0 until leng ; j <- 0 until instNum(i)) {
      r += ((i, j) -> Roundrobin(args(i), uw(i)).setName(s"rr_${i}_${j}"))
  }

  for (i <- 0 until leng ; j <- 0 until instNum(i) ; k <- 0 until args(i)) {
      val s = r((i, j)).io.S(k)
      val index = j*args(i)+k
      if (i == theLast)
        s << io.S(index)
      else {
        s.ready <> r((i+1, index)).io.M.ready
        s.valid <> r((i+1, index)).io.M.valid
        s.payload := (r((i+1, index)).io.bin @@ r((i+1, index)).io.M.payload)
     }
  }

  io.M.ready <> r((0, 0)).io.M.ready
  io.M.valid <> r((0, 0)).io.M.valid
  io.M.payload := r((0, 0)).io.M.payload(0, userWidth bits)
  io.bin := r((0, 0)).io.bin @@ (r((0, 0)).io.M.payload >> userWidth)
}


case class RoundStrict (hotWidth: Int, userWidth: Int = 0) extends Component {

  val binWidth = log2Up(hotWidth)

  val io = new Bundle {
    val bin = out UInt (binWidth bits)
    val S = Vec(slave Stream (UInt(userWidth bits)), hotWidth)
    val M = master Stream (UInt(userWidth bits))
  }

  noIoPrefix()
  setDefinitionName(s"RoundStrict_u${userWidth}_h${hotWidth}")

  val s = Hot2binLowFirst(binWidth)
  for (i <- 0 until hotWidth) {
    s.io.hot(i) := io.S(i).valid
    io.S(i).ready := False
  }
  io.M <-< io.S(s.io.bin)
  io.bin := RegNext(s.io.bin) init 0
}

object ArbiterVerilog extends App {
//  Config.spinal.generateVerilog(Bin2hotTest(3) )
//  Config.spinal.generateVerilog(Hot2binLowFirst(3) )
//  Config.spinal.generateVerilog(Roundrobin(8, 2) )
//  Config.spinal.generateVerilog(RoundrobinTree(Array(2, 4), 2) )
//  Config.spinal.generateVerilog(RoundrobinTree(Array(2, 4, 8)) )
  Config.spinal.generateVerilog(RoundStrict(4, 1) )
}

