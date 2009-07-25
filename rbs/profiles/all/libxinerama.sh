#!/bin/bash

VERSION="1.0.3"
SYS_VERSION="1.0.3-1"

DIR="libXinerama-${VERSION}"
TARBALL="libXinerama-${VERSION}.tar.bz2"

DEPENDS=(
  libxext
  xineramaproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
cd9f7c46439ac40e0517a302d2434d2c
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
  VERSION_STRING='libXinerama-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXinerama-%version%.tar.bz2'
  )
}
