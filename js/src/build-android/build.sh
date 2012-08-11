#!/bin/sh

# configure
../configure --with-android-ndk=$HOME/bin/android-ndk \
             --with-android-sdk=$HOME/bin/android-sdk \
             --with-android-version=5 \
             --with-android-toolchain=$HOME/bin/android-ndk/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86 \
             --enable-application=mobile/android \
             --target=arm-linux-androideabi \
             --disable-shared-js \
             --disable-tests \
             --enable-strip \
             --enable-install-strip \
             --enable-debug \
             --disable-methodjit \
             --disable-monoic \
             --disable-polyic

# make
make -j4

# copy specific files from dist
mkdir -p ../../../dist
mkdir -p ../../../dist/include
cp -RL dist/include/* ../../../dist/include/
mkdir -p ../../../dist/lib
cp -RL dist/lib/libjs_static.a ../../../dist/lib/libjs_static.a

# strip unneeded symbols
$HOME/bin/android-ndk/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86/bin/arm-linux-androideabi-strip --strip-unneeded ../../../dist/lib/libjs_static.a
