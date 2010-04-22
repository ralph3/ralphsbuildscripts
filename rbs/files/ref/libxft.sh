#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.1.14"

DIR="libXft-${VERSION}"
TARBALL="libXft-${VERSION}.tar.bz2"

DEPENDS=(
  fontconfig
  libxrender
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
254e62a233491e0e1251636536163e20
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/xft-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/lib/'
  VERSION_STRING='libXft-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXft-%version%.tar.bz2'
  )
}