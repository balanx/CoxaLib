// https://github.com/balanx/Coxalib

package coxa.lib

import spinal.core._
import spinal.lib._
import spinal.core.sim._

import scala.collection.mutable.Queue
import org.scalatest.funsuite.AnyFunSuite


class StramTests extends AnyFunSuite {
  test("the name is StramTests") {
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
}

