#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.8.0"

DIR="cairomm-${VERSION}"
TARBALL="cairomm-${VERSION}.tar.gz"

DEPENDS=(
  libsigc++
)

SRC1=(
http://cairographics.org/releases/${TARBALL}
)

MD5SUMS=(
15c0f56eee57bb418c38463a6297d715
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://cairographics.org/releases/'
  VERSION_STRING='cairomm-%version%.tar.gz'
  MIRRORS=(
    'http://cairographics.org/releases/cairomm-%version%.tar.gz'
  )
}
