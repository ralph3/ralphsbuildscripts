#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.1"

DIR="xcursor-themes-${VERSION}"
TARBALL="xcursor-themes-${VERSION}.tar.bz2"

DEPENDS=(
  xcursorgen
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/data/${TARBALL}
)

MD5SUMS=(
014bad415e64c49994679cdb71a97e37
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/data/'
  VERSION_STRING='xcursor-themes-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/data/xcursor-themes-%version%.tar.bz2'
  )
}
