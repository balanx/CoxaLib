// https://github.com/balanx/Coxalib

package coxa.lib

import spinal.core._
import spinal.lib._
import spinal.core.sim._

import scala.util.Random
import scala.collection.mutable.Queue
import org.scalatest.funsuite.AnyFunSuite


class StramTests extends AnyFunSuite {
  test("1. Sync. StramTests") {
//object StramTests {
//  def main(args: Array[String]): Unit = {

    // Compile the Component for the simulator.
    val compiled = SimConfig.withWave.allOptimisation.compile(
//      rtl = new RamPipe(8)
      rtl = new Fifo(10, 8, regOut = true)
    )

    // Run the simulation.
    compiled.doSimUntilVoid{dut =>
      val queueModel = Queue[Long]()

      dut.clockDomain.forkStimulus(period = 10)
      val simLength = 100000
      SimTimeout(simLength*10 + 1000)

      // Push data randomly, and fill the queueModel with pushed transactions.
      val pushThread = fork {
        dut.io.S.valid #= false
        var data = 0
        while(true) {
          dut.io.S.valid.randomize()
          dut.clockDomain.waitSampling()
          if(dut.io.S.valid.toBoolean && dut.io.S.ready.toBoolean) {
//            dut.io.S.payload.randomize()
            data = if (data >= 255) 0 else (data + 1)
            dut.io.S.payload #= data
            queueModel.enqueue(dut.io.S.payload.toLong)
          }
        }
      }

      // Pop data randomly, and check that it match with the queueModel.
      val popThread = fork {
        dut.io.M.ready #= true
        for(i <- 0 until simLength) {
          dut.io.M.ready.randomize()
          dut.clockDomain.waitSampling()
          if(dut.io.M.valid.toBoolean && dut.io.M.ready.toBoolean) {
            val q = queueModel.dequeue()
            println(dut.io.M.payload.toLong , q)
            assert(dut.io.M.payload.toLong == q)
          }
        }
        simSuccess()
      }
    }
  }


  test("2. Async. StramTests") {
    // Compile the Component for the simulator.
    val compiled = SimConfig.withWave.allOptimisation.compile(
//      rtl = new StreamFifoCC(
//        dataType = Bits(32 bits),
//        depth = 32,
//        pushClock = ClockDomain.external("clkA"),
//        popClock = ClockDomain.external("clkB",withReset = false)
//      )

      rtl = new Fifo(10, 8, async = true, regOut = true)
    )

    // Run the simulation.
    compiled.doSimUntilVoid{dut =>
//      val queueModel = mutable.Queue[Long]()
      val queueModel = Queue[Long]()
      val clkA = ClockDomain(dut.CKA, dut.RSTA).forkStimulus(10)
      val clkB = ClockDomain(dut.CKB, dut.RSTB).forkStimulus(5)

      // Fork a thread to manage the clock domains signals
      val clocksThread = fork {
        // Clear the clock domains' signals, to be sure the simulation captures their first edges.
        dut.clkA.fallingEdge()
        dut.clkB.fallingEdge()
        dut.clkA.deassertReset()
        dut.clkB.deassertReset()
        sleep(0)

        // Do the resets.
        dut.clkA.assertReset()
        dut.clkB.assertReset()
        sleep(10)
        dut.clkA.deassertReset()
        dut.clkB.deassertReset()
        sleep(1)

        // Forever, randomly toggle one of the clocks.
        // This will create asynchronous clocks without fixed frequencies.
        while(true) {
          if(Random.nextBoolean()) {
            dut.clkA.clockToggle()
          } else {
            dut.clkB.clockToggle()
          }
          sleep(1)
        }
      }

      // Push data randomly, and fill the queueModel with pushed transactions.
      val pushThread = fork {
        while(true) {
          dut.io.S.valid.randomize()
          dut.io.S.payload.randomize()
          dut.clkA.waitSampling()
          if(dut.io.S.valid.toBoolean && dut.io.S.ready.toBoolean) {
            queueModel.enqueue(dut.io.S.payload.toLong)
          }
        }
      }

      // Pop data randomly, and check that it match with the queueModel.
      val popThread = fork {
        for(i <- 0 until 100000) {
          dut.io.M.ready.randomize()
          dut.clkB.waitSampling()
          if(dut.io.M.valid.toBoolean && dut.io.M.ready.toBoolean) {
            assert(dut.io.M.payload.toLong == queueModel.dequeue())
          }
        }
        simSuccess()
      }
    }
  }


}

