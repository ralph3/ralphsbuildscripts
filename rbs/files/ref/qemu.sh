#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.12.3"

TARBALL="qemu-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://download.savannah.gnu.org/releases/qemu/${TARBALL}
)

MD5SUMS=(
d215e4568650e8019816397174c090e1
)

build(){
  unset CFLAGS CXXFLAGS
  DIR=$(get_tarball_dir $DOWNLOADDIR/$TARBALL)
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --enable-kvm --audio-drv-list=alsa || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
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