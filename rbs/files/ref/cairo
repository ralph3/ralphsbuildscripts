#!/bin/bash

VERSION="1.8.10"
SYS_VERSION="1.8.10-1"

DIR="cairo-${VERSION}"
TARBALL="cairo-${VERSION}.tar.gz"

DEPENDS=(
  espgs
  fontconfig
  libpng
  libxcb
  libxrender
  pixman
)

SRC1=(
http://cairographics.org/releases/${TARBALL}
)

MD5SUMS=(
b60a82f405f9400bbfdcf850b1728d25
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
  VERSION_STRING='cairo-%version%.tar.gz'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://cairographics.org/releases/cairo-%version%.tar.gz'
  )
}
