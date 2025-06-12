// https://github.com/balanx/Coxalib

package coxa.lib

import spinal.core._
import spinal.lib._
import spinal.core.sim._

import scala.util.Random
import scala.collection.mutable.Queue
import org.scalatest.funsuite.AnyFunSuite


class ArbiterTest extends AnyFunSuite {
/*
  test("1. Bin2hotTest") {

    val compiled = Config.sim.compile(
      rtl = Bin2hotTest(3)
    )

    compiled.doSim{ dut =>
      dut.io.bin #= 0
      sleep(1)
      printf("%h, %h\n", dut.io.bin.toInt, dut.io.hot.toInt)
      assert(dut.io.hot.toInt == 0xfe)

      dut.io.bin #= 3
      sleep(1)
      printf("%h, %h\n", dut.io.bin.toInt, dut.io.hot.toInt)
      assert(dut.io.hot.toInt == 0xf0)

      dut.io.bin #= 7
      sleep(1)
      printf("%h, %h\n", dut.io.bin.toInt, dut.io.hot.toInt)
      assert(dut.io.hot.toInt == 0)
    }
  }
*/
  test("2. Hot2binLowFirst") {

    val compiled = Config.sim.compile(
      rtl = Hot2binLowFirst(3)
    )

    compiled.doSim{ dut =>
      dut.io.hot #= 0xf
      sleep(1)
      printf("%h, %h\n", dut.io.hot.toInt, dut.io.bin.toInt)
      assert(dut.io.bin.toInt == 0)

      dut.io.hot #= 0xf0
      sleep(1)
      printf("%h, %h\n", dut.io.hot.toInt, dut.io.bin.toInt)
      assert(dut.io.bin.toInt == 4)

      dut.io.hot #= 0x80
      sleep(1)
      printf("%h, %h\n", dut.io.hot.toInt, dut.io.bin.toInt)
      assert(dut.io.bin.toInt == 7)
    }
  }

  test("3. Roundrobin") {

    val compiled = Config.sim.compile(
      rtl = Roundrobin(8, 3)
    )

    compiled.doSim{ dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.M.ready #= true

      dut.io.S(0).payload #= 0
      dut.io.S(1).payload #= 1
      dut.io.S(2).payload #= 2
      dut.io.S(3).payload #= 3
      dut.io.S(4).payload #= 4
      dut.io.S(5).payload #= 5
      dut.io.S(6).payload #= 6
      dut.io.S(7).payload #= 7

      dut.io.S(0).valid #= false
      dut.io.S(1).valid #= false
      dut.io.S(2).valid #= false
      dut.io.S(3).valid #= false
      dut.io.S(4).valid #= true
      dut.io.S(5).valid #= false
      dut.io.S(6).valid #= false
      dut.io.S(7).valid #= false

      dut.clockDomain.waitSampling(6)
      var loop = true
      while(loop) {
        dut.clockDomain.waitSampling()
        if (dut.io.S(4).ready.toBoolean) {
          dut.io.S(4).valid #= false
          loop = false
        }
      }
      printf("%h, %h\n", dut.io.M.payload.toInt, dut.io.bin.toInt)
      assert(dut.io.M.payload.toInt == 4 && dut.io.bin.toInt == 4)

      dut.clockDomain.waitSampling(6)
      dut.io.S(0).valid #= true
      dut.io.S(1).valid #= true
      dut.io.S(2).valid #= true
      dut.io.S(3).valid #= true
      dut.io.S(4).valid #= true
      dut.io.S(5).valid #= true
      dut.io.S(6).valid #= true
      dut.io.S(7).valid #= true

      dut.clockDomain.waitSampling(2)
      printf("%h, %h\n", dut.io.M.payload.toInt, dut.io.bin.toInt)
      assert(dut.io.M.payload.toInt == 5 && dut.io.bin.toInt == 5)
      dut.clockDomain.waitSampling(20)
    }
  }

  test("4. RoundStrict") {

    val compiled = Config.sim.compile(
      rtl = RoundStrict(4, 2)
    )

    compiled.doSim{ dut =>
      dut.clockDomain.forkStimulus(period = 10)
      dut.io.M.ready #= true

      dut.io.S(0).payload #= 0
      dut.io.S(1).payload #= 1
      dut.io.S(2).payload #= 2
      dut.io.S(3).payload #= 3

      dut.io.S(0).valid #= false
      dut.io.S(1).valid #= false
      dut.io.S(2).valid #= true
      dut.io.S(3).valid #= true

      dut.clockDomain.waitSampling(6)
      var loop = true
      while(loop) {
        dut.clockDomain.waitSampling()
        if (dut.io.S(2).ready.toBoolean) {
          dut.io.S(2).valid #= false
          loop = false
        }
      }
      printf("%h, %h\n", dut.io.M.payload.toInt, dut.io.bin.toInt)
      assert(dut.io.M.payload.toInt == 2 && dut.io.bin.toInt == 2)

      dut.clockDomain.waitSampling(6)
      printf("%h, %h\n", dut.io.M.payload.toInt, dut.io.bin.toInt)
      assert(dut.io.M.payload.toInt == 3 && dut.io.bin.toInt == 3)

      dut.io.S(0).valid #= true
      dut.io.S(1).valid #= true
      dut.clockDomain.waitSampling(2)
      printf("%h, %h\n", dut.io.M.payload.toInt, dut.io.bin.toInt)
      assert(dut.io.M.payload.toInt == 0 && dut.io.bin.toInt == 0)
      dut.clockDomain.waitSampling(20)
    }
  }

}

