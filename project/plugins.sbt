val SONATYPE_CENTRAL_VERSION = sys.env.getOrElse("SONATYPE_CENTRAL_VERSION", "0.2.0")
addSbtPlugin("com.lumidion" % "sbt-sonatype-central" % SONATYPE_CENTRAL_VERSION)

//libraryDependencies += "org.scala-sbt" %% "scripted-plugin" % sbtVersion.value

addSbtPlugin("org.scalameta"  % "sbt-scalafmt" % "2.4.6")
addSbtPlugin("com.github.sbt" % "sbt-pgp"      % "2.2.1")
addSbtPlugin("com.github.sbt" % "sbt-git"      % "2.0.1")
addSbtPlugin("com.eed3si9n"   % "sbt-assembly" % "1.1.0")
