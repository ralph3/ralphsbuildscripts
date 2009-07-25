#!/bin/bash

VERSION="1.0.2"
SYS_VERSION="1.0.2-1"

DIR="libXxf86vm-${VERSION}"
TARBALL="libXxf86vm-${VERSION}.tar.bz2"

DEPENDS=(
  xf86vidmodeproto
  libxext
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
304d37bd0a10d9b58aa9b64469ad73e5
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
  VERSION_STRING='libXxf86vm-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXxf86vm-%version%.tar.bz2'
  )
}
