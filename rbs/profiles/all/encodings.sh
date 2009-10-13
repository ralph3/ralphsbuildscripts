#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.3"

DIR="encodings-${VERSION}"
TARBALL="encodings-${VERSION}.tar.bz2"

DEPENDS=(
  mkfontscale
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/font/${TARBALL}
)

MD5SUMS=(
29637480e7ce12546668631067c19ced
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
  VERSION_STRING='encodings-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/font/encodings-%version%.tar.bz2'
  )
}
