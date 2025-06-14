// https://github.com/balanx/Coxalib

package coxa.lib

import spinal.core._
import spinal.core.sim._

object Config {
  def spinal = SpinalConfig(
    rtlHeader = "https://github.com/balanx/Coxalib",
    targetDirectory = "hw/gen",
    normalizeComponentClockDomainName = true,
    inlineConditionalExpression = true,
    nameWhenByFile = false,
    globalPrefix   = "CX_",
    withTimescale  = false,
//    headerWithRepoHash = false,
    defaultConfigForClockDomains = ClockDomainConfig(
      resetActiveLevel = HIGH
    ),
    onlyStdLogicVectorAtTopLevelIo = false
  )

  def sim = SimConfig.withConfig(spinal).withFstWave
}
