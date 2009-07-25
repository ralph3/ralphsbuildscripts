#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10.5"

TARBALL="qemu-${VERSION}.tar.gz"

DEPENDS=(
  alsa-lib
  sdl
)

SRC1=(
http://download.savannah.gnu.org/releases/qemu/${TARBALL}
)

MD5SUMS=(
60060feb98c9649a5da8b136685f76ba
)

build(){
  unset CFLAGS CXXFLAGS
  DIR=$(get_tarball_dir $DOWNLOADDIR/$TARBALL)
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr || return 1
  make || return 1
  make prefix=$TMPROOT/usr \
       bindir=$TMPROOT/usr/bin \
       libdir=$TMPROOT/usr/$LIBSDIR \
       mandir=$TMPROOT/usr/share/man \
       datadir=$TMPROOT/usr/share/qemu \
       docdir=$TMPROOT/usr/share/doc/qemu \
       install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://download.savannah.gnu.org/releases/qemu/'
  VERSION_STRING='qemu-%version%.tar.gz'
  MIRRORS=(
    "http://download.savannah.gnu.org/releases/qemu/qemu-%version%.tar.gz"
  )
}
