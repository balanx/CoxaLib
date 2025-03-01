// https://github.com/balanx/Coxalib

package coxa.base

import spinal.core._
import spinal.lib._
import spinal.core.sim._

import scala.collection.mutable.Queue


object TestRam2Stream {
  def main(args: Array[String]): Unit = {
    // Compile the Component for the simulator.
//    val compiled = SimConfig.withWave.allOptimisation.compile(
    val compiled = Config.sim.compile(
      rtl = Ram2Stream(8, 1024, userWidth = 4)
    )

    // Run the simulation.
    compiled.doSimUntilVoid{dut =>
      val queueModel = Queue[Long]()

//      dut.clockDomain.forkStimulus(period = 10)
      val clk = ClockDomain(dut.io.CK)
      clk.forkStimulus(period = 10)
      dut.io.W.valid  #= false
      dut.io.Ri.valid #= false
      dut.io.Ro.ready #= true
      sleep(100)

      // Push data randomly, and fill the queueModel with pushed transactions.
      val writeThread = fork {
        dut.io.W.valid #= true
        for(i <- 0 to 9) {
//          dut.io.push.valid.randomize()
          dut.io.W.payload.addr #= i
          dut.io.W.payload.data #= i + 1
          println("debug = ", i, dut.io.W.payload.addr.toInt)
//          dut.clockDomain.waitSampling()
          clk.waitSampling()
        }
        dut.io.W.valid #= false
//        dut.clockDomain.waitSampling()
        clk.waitSampling()
//        simSuccess()
      }

      val riThread = fork {
        sleep(100)
        dut.io.Ri.valid #= true
        for (i <- 0 to 9) {
//          dut.io.Ri.valid.randomize()
          dut.io.Ri.payload.addr #= i
          dut.io.Ri.payload.user #= i
//          println("debug = ", i, dut.io.Ri.payload.addr.toInt, dut.io.Ri.payload.user.toInt)
          clk.waitSampling()
//          println("debug = ", i, dut.io.Ri.payload.addr.toInt)
        }
        dut.io.Ri.valid #= false
        clk.waitSampling()
        simSuccess()
      }

      // Pop data randomly, and check that it match with the queueModel.
//      val popThread = fork {
//        dut.io.pop.ready #= true
//        for(i <- 0 until 100000) {
//          dut.io.pop.ready.randomize()
//          dut.clockDomain.waitSampling()
//          if(dut.io.pop.valid.toBoolean && dut.io.pop.ready.toBoolean) {
//            assert(dut.io.pop.payload.toLong == queueModel.dequeue())
//          }
//        }
//        simSuccess()
//      }
    }
  }
}




