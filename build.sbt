ThisBuild / version := "0.0.3"
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


val spinalVersion = "1.12.0"
val spinalCore = "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion
val spinalLib = "com.github.spinalhdl" %% "spinalhdl-lib" % spinalVersion
val spinalIdslPlugin = compilerPlugin("com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion)

val commonSettings = Seq(

    publishTo := sonatypeCentralPublishToBundle.value,
    fork := true,

    libraryDependencies += "org.scalactic" %% "scalactic" % "3.2.19",
    libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.19" % "test",
    libraryDependencies ++= Seq(spinalCore, spinalLib, spinalIdslPlugin),

    assembly / assemblyMergeStrategy := {
      case PathList("META-INF", xs @ _*) => MergeStrategy.discard
      case x => MergeStrategy.first
    }
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

