#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.2.0"

DIR="kdemultimedia-${VERSION}"
TARBALL="kdemultimedia-${VERSION}.tar.bz2"

DEPENDS=(
  kdebase
  lame
  sdl
  speex
  xine-lib
)

SRC1=(
ftp://ftp.kde.org/pub/kde/stable/latest/src/$TARBALL
)

MD5SUMS=(
3e944c87888ac1ac5b11d3722dd31f88
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc/kde --libdir=/usr/$LIBSDIR \
    --disable-dependency-tracking || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.kde.org/pub/kde/stable/latest/src/'
  VERSION_STRING='kdemultimedia-%version%.tar.bz2'
  MIRRORS=(
    'ftp://ftp.kde.org/pub/kde/stable/latest/src/kdemultimedia-%version%.tar.bz2'
  )
}
