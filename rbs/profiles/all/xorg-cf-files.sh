#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.2"

DIR="xorg-cf-files-${VERSION}"
TARBALL="xorg-cf-files-${VERSION}.tar.bz2"

DEPENDS=(
  xorg-server
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/util/${TARBALL}
)

MD5SUMS=(
5f62dd5545b782c74f6e4e70d0e6552c
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/util/'
  VERSION_STRING='xorg-cf-files-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/util/xorg-cf-files-%version%.tar.bz2'
  )
}
