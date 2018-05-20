# etu-csu

A quick and dirty port of NetBSD CSU

## Getting Started
If you have clang installed it should be as simple as running ./build.sh 

See the contents of build.sh. You can override settings by defining variables
on the commandline. For instance to build i386 on x86_64 with clang your can
run...

```
ARCH=i386 CPPFLAGS=-m32 ./build.sh
```
