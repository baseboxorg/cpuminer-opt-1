#!/bin/bash

make clean || echo clean

rm -f config.status
./autogen.sh || echo done

# icon
x86_64-w64-mingw32-windres res/icon.rc icon.o

CFLAGS="-O3 -march=corei7 -Wall" CXXFLAGS="$CFLAGS -std=gnu++11 -fpermissive" LDFLAGS="icon.o" ./configure --with-curl

make

strip -p --strip-debug --strip-unneeded cpuminer.exe

if [ -e sign.sh ] ; then
. sign.sh
fi

mkdir -p deploy
mv cpuminer.exe deploy/cpuminer-opt-nehalem.exe