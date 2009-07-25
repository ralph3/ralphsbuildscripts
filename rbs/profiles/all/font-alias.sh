#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.1"

DIR="font-alias-${VERSION}"
TARBALL="font-alias-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/font/${TARBALL}
)

MD5SUMS=(
c4776b6f0f2ecdb7670b6fe64b5d2a2d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/usr/share || return 1
  cp -a $TMPROOT/usr/$LIBSDIR/* $TMPROOT/usr/share/ || return 1
  rm -rf $TMPROOT/usr/$LIBSDIR || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/font/'
  VERSION_STRING='font-alias-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/font/font-alias-%version%.tar.bz2'
  )
}
