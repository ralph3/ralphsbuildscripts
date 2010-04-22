#!/bin/bash

VERSION="1.1.1"

DIR="libXext-${VERSION}"
TARBALL="libXext-${VERSION}.tar.bz2"

DEPENDS=(
  xextproto
  libx11
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
c417c0e8df39a067f90a2a2e7133637d
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
  VERSION_STRING='libXext-%version%.tar.bz2'
  VERSION_FILTERS='99'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXext-%version%.tar.bz2'
  )
}