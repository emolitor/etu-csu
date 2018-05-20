# etu-csu

A quick and dirty port of NetBSD CSU crtbegin and crtend.
Primarily to support using C++ with [musl libc](https://musl-libc.org).

## Getting Started
If you have clang installed it should be as simple as running ./build.sh 
```
./build.sh
```

See the contents of build.sh for defaults. You can override settings by 
defining variables on the commandline. For instance to build i386 on x86_64
with clang you can run...

```
ARCH=i386 CPPFLAGS=-m32 ./build.sh
```

You will find the resultant files in output/$ARCH
