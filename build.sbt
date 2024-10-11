//import xerial.sbt.Sonatype.sonatypeCentralHost
//ThisBuild / sonatypeCredentialHost := sonatypeCentralHost

ThisBuild / version := "0.0.1-SNAPSHOT"
ThisBuild / organization := "com.github.balanx"
ThisBuild / organizationName := "balanx"
ThisBuild / organizationHomepage := Some(url("https://github.com/balanx/"))

ThisBuild / scmInfo := Some(
  ScmInfo(
    url("https://github.com/balanx/CoxaLib"),
    "scm:git@github.com:balanx/CoxaLib.git"
  )
)
ThisBuild / developers := List(
  Developer(
    id = "balanx",
    name = "balanx",
    email = "tobalanx@gmail.com",
    url = url("https://github.com/balanx/CoxaLib")
  )
)



ThisBuild / description := "A design library with Spinal HDL."
ThisBuild / licenses := List(
  "LGPL3" -> new URL("https://www.gnu.org/licenses/lgpl-3.0.html")
)
ThisBuild / homepage := Some(url("https://github.com/balanx/CoxaLib"))

// Remove all additional repository other than Maven Central from POM
ThisBuild / pomIncludeRepository := { _ => false }
ThisBuild / publishTo := {
  // For accounts created after Feb 2021:
  //val nexus = "https://s01.oss.sonatype.org/"
  //val nexus = "https://oss.sonatype.org/"
  val nexus = "https://central.sonatype.com/"
  if (isSnapshot.value) Some("snapshots" at nexus + "content/repositories/snapshots")
  else Some("releases" at nexus + "service/local/staging/deploy/maven2")
}
ThisBuild / publishMavenStyle := true

//credentials += Credentials(Path.userHome / ".sbt" / "sonatype_credential")

//publishTo := sonatypePublishToBundle.value
