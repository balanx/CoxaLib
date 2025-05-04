ThisBuild / version := "1.0"
ThisBuild / scalaVersion := "2.13.14"
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


publishTo := sonatypeCentralPublishToBundle.value
//publishMavenStyle := true


val spinalVersion = "1.12.0"
val spinalCore = "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion
val spinalLib = "com.github.spinalhdl" %% "spinalhdl-lib" % spinalVersion
val spinalIdslPlugin = compilerPlugin("com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion)

val commonSettings = Seq(
    fork := true,
    libraryDependencies ++= Seq(spinalCore, spinalLib, spinalIdslPlugin)
)

lazy val root = (project in file("."))
  .settings(
    commonSettings,
    name := "Coxa-root"
    //Compile / scalaSource := baseDirectory.value / "hw" / "spinal",
  )
  .aggregate(lib)
  //.dependsOn(lib)


lazy val lib = project
  .settings(
    commonSettings,
    name := "Coxa-lib"
  )


//
//lazy val hello = taskKey[Unit]("Prints 'Hello, World!'")
//
//hello := {
//  println("Hello, World!")
//}

