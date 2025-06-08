// https://github.com/balanx/Coxalib

package coxa.lib

import spinal.core._
import spinal.lib._
import spinal.core.sim._

import scala.util.Random
import scala.collection.mutable.Queue
import org.scalatest.funsuite.AnyFunSuite


class MiscTest extends AnyFunSuite {
  test("1. Sync. StramTests") {

    val compiled = Config.sim.compile(
      rtl = Bin2hotTest(3)
    )

    compiled.doSim{ dut =>
      dut.io.bin #= 3
      sleep(1)
      printf("%h, %h\n", dut.io.bin.toInt, dut.io.hot.toInt)
    }
  }


  test("2. Sync. StramTests") {

    class Dut extends Component {
      val io = new Bundle {
        val a, b, c = in UInt (8 bits)
        val result = out UInt (8 bits)
      }
      io.result := io.a + io.b - io.c
    }

    val compiled = SimConfig.withWave.allOptimisation.compile(
      rtl = new Dut
    )

    compiled.doSim{ dut =>
      var idx = 0
      while(idx < 100) {
        val a, b, c = Random.nextInt(256)
        dut.io.a #= a
        dut.io.b #= b
        dut.io.c #= c
        sleep(1) // Sleep 1 simulation timestep
        assert(dut.io.result.toInt == ((a + b - c) & 0xFF))
        idx += 1
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

