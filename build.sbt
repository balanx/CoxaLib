//import scala.collection.Seq

//addCommandAlias("fmt", "all root/scalafmtSbt root/scalafmtAll")
//addCommandAlias("fmtCheck", "all root/scalafmtSbtCheck root/scalafmtCheckAll")

val versions = new {
  val coxa              =   "0.0.2"
  val scala             =   "2.13.14"
  val spinal            =   "1.11.0"
}

publishTo := sonatypeCentralPublishToBundle.value
//publishMavenStyle := true


ThisBuild / version := versions.coxa
ThisBuild / scalaVersion := versions.scala
ThisBuild / organization := "io.github.balanx"

ThisBuild / licenses := Seq("Apache-2.0" -> url("http://www.apache.org/licenses/LICENSE-2.0"))
ThisBuild / homepage := Some(url("https://github.com/balanx/CoxaLib"))
ThisBuild / developers := List(
  Developer(
    id = "balanx",
    name = "CoxaLib",
    email = "tobalanx@gmail.com",
    url = url("https://github.com/balanx/")
  )
)


// Project
val spinalVersion = versions.spinal
val spinalCore = "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion
val spinalLib = "com.github.spinalhdl" %% "spinalhdl-lib" % spinalVersion
val spinalIdslPlugin = compilerPlugin("com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion)


lazy val coxalib = (project in file("."))
  .settings(
    //Compile / scalaSource := baseDirectory.value / "hw" / "spinal",
    libraryDependencies ++= Seq(spinalCore, spinalLib, spinalIdslPlugin)
  )

fork := true

