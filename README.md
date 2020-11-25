# MantleInstaller
MantleInstaller is an installer for [Mantle.club](https://mantle.club) written in Nim. It edits your hosts file and sets s.optifine.net to an IP.  
To create a debug build run `nimble debug`.  
To create a release build run `nimble release`.  
The release build script builds MantleInstaller with Clang for Linux, and builds it with GCC from mingw for Windows.  
The release build script automates the process of cross-compiling for Windows from a Linux machine.  
If you're not on Linux, it's unlikely that either build script will work.
