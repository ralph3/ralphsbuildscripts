#!/bin/bash

VERSION="0.4.0"
SYS_VERSION="0.4.0-1"

DIR="libXcomposite-${VERSION}"
TARBALL="libXcomposite-${VERSION}.tar.bz2"

DEPENDS=(
  compositeproto
  libxfixes
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
7e95395dea89be21bae929b9b7f16641
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
  VERSION_STRING='libXcomposite-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXcomposite-%version%.tar.bz2'
  )
}
