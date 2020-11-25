# Package

version       = "0.0.1"
author        = "creatable"
description   = "The Shawl installer."
license       = "MIT"
srcDir        = "src"
bin           = @["MantleInstaller"]

# Dependencies

requires "nim >= 1.4.0"

# Build scripts

task release, "Makes a release build":
  # Linux build
  exec("nim c --cc:clang --opt:size --cpu:i386 -t:-m32 -l:-m32 -d:release --out:bin/release/ " & srcDir & "/" & bin[0] & ".nim")
  exec("strip bin/release/" & bin[0])

  # Windows build
  exec("nim c -d:mingw --opt:size --cpu:i386 -t:-m32 -l:-m32 -d:release --out:bin/release/ " & srcDir & "/" & bin[0] & ".nim")
  exec("wine mt.exe -manifest \"" & bin[0] & ".exe.manifest\" -outputresource:\"" & "bin\\release\\" & bin[0] & ".exe\";#1")

task debug, "Makes a debug build":
  exec("nim c --cc:clang --opt:size --out:bin/debug/ " & srcDir & "/" & bin[0] & ".nim")