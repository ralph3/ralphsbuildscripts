#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.2"

DIR="libXxf86dga-${VERSION}"
TARBALL="libXxf86dga-${VERSION}.tar.bz2"

DEPENDS=(
  xf86dgaproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
6f5f621804ee652b6cc6f2025c517c78
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
  VERSION_STRING='libXxf86dga-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXxf86dga-%version%.tar.bz2'
  )
}
