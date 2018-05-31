#!/bin/sh
#
# In addition to the variables below you can pass bmake variables on the
# commandline. For instance to cross compile i386 on x86_64 with clang...
#
# ARCH=i386 ./build.sh

SYSTEM="${ARCH:-`uname -s`}"
ARCH="${ARCH:-`uname -m`}"

if [ -x "$(command -v bmake)" ]; then
	BMAKE="${BMAKE:-`command -v bmake`}"
else
	echo "ERROR: Please install bmake"
	exit 1
fi

if [ -x "$(command -v gobjcopy)" ]; then
	OBJCOPY="${OBJCOPY:-`command -v gobjcopy`}"
else
	OBJCOPY="${OBJCOPY:-`command -v objcopy`}"
fi

if [ -x "$(command -v clang)" ]; then
	 CC="${CC:-`command -v clang`}"
else
	 CC="${CC:-`command -v cc`}"
fi

if [ $ARCH = "x86_64" ]; then
	ARCH_LINK="amd64"
else
	ARCH_LINK="$ARCH"
fi

if [ $ARCH = "amd64" ]; then
	ARCH="x86_64"
fi

BMAKE_FLAGS="MKPIC=yes MKSTRIPIDENT=no OBJCOPY=$OBJCOPY CC=$CC"

if [ $SYSTEM = "FreeBSD" ]; then
	BMAKE_FLAGS="-m /usr/local/share/mk $BMAKE_FLAGS"
fi

case "$CC" in
  *clang*)
	AFLAGS="--target=$ARCH-pc-linux $AFLAGS"
  ;;
esac

BMAKE_FLAGS="AFLAGS=$AFLAGS $BMAKE_FLAGS"

ln -s $PWD/sys/arch/$ARCH_LINK/include lib/csu/common/machine

MACHINE_ARCH=$ARCH $BMAKE $@ $BMAKE_FLAGS -C lib/csu crtbegin.o
MACHINE_ARCH=$ARCH $BMAKE $@ $BMAKE_FLAGS -C lib/csu crtbeginS.o
MACHINE_ARCH=$ARCH $BMAKE $@ $BMAKE_FLAGS -C lib/csu crtend.o

mkdir -p output/$ARCH
mv lib/csu/*.o output/$ARCH
rm lib/csu/common/machine
