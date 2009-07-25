#!/bin/bash

VERSION="1.0.6"
SYS_VERSION="1.0.6-1"

DIR="libXt-${VERSION}"
TARBALL="libXt-${VERSION}.tar.bz2"

DEPENDS=(
  libice
  libsm
  libx11
  libxdmcp
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
953930ddf9fdaa1405732c7f01e9e599
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/lib/'
  VERSION_STRING='libXt-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXt-%version%.tar.bz2'
  )
}
