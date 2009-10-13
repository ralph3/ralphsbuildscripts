#!/bin/bash

VERSION="4.0.4"

DIR="libXfixes-${VERSION}"
TARBALL="libXfixes-${VERSION}.tar.bz2"

DEPENDS=(
  libx11
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
7f2c40852eb337b237ad944ca5c30d49
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
  VERSION_STRING='libXfixes-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXfixes-%version%.tar.bz2'
  )
}
