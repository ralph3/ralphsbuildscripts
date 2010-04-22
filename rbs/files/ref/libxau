#!/bin/bash

VERSION="1.0.5"

DIR="libXau-${VERSION}"
TARBALL="libXau-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
993b3185c629e4b89401fca072dcb663
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
  VERSION_STRING='libXau-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXau-%version%.tar.bz2'
  )
}
