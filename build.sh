#!/bin/sh
#
# In addition to the variables below you can pass bmake variables on the
# commandline. For instance to cross compile i386 on x86_64 with clang...
#
# ARCH=i386 ./build.sh CPPFLAGS=-m32

ARCH="${ARCH:-`uname -m`}"
OBJCOPY="${OBJCOPY:-`which objcopy`}"
BMAKE="${BMAKE:-`which bmake`}"
CC="${CC:-`which clang`}"
MK="${MK:-/usr/local/share/mk}"

BMAKE_FLAGS="-m $MK MKPIC=yes MKSTRIPIDENT=no OBJCOPY=$OBJCOPY CC=$CC"

if [ $ARCH = "x86_64" ]; then
	ARCH_LINK="amd64"
else
	ARCH_LINK="$ARCH"
fi

BMAKE_FLAGS="MKPIC=yes MKSTRIPIDENT=no OBJCOPY=$OBJCOPY CC=$CC -m $MK"

ln -s $PWD/sys/arch/$ARCH_LINK/include lib/csu/common/machine

MACHINE_ARCH=$ARCH $BMAKE $@ $BMAKE_FLAGS -C lib/csu crtbegin.o
MACHINE_ARCH=$ARCH $BMAKE $@ $BMAKE_FLAGS -C lib/csu crtbeginS.o
MACHINE_ARCH=$ARCH $BMAKE $@ $BMAKE_FLAGS -C lib/csu crtend.o

mkdir -p output/$ARCH
mv lib/csu/*.o output/$ARCH
rm lib/csu/common/machine
