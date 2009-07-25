#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.0"

DIR="setxkbmap-${VERSION}"
TARBALL="setxkbmap-${VERSION}.tar.bz2"

DEPENDS=(
  libxkbfile
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
2f902e0a89aaf2b19e06e7f26c6efb3a
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/app/'
  VERSION_STRING='setxkbmap-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/setxkbmap-%version%.tar.bz2'
  )
}
