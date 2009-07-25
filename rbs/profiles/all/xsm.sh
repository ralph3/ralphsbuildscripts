#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.1"

DIR="xsm-${VERSION}"
TARBALL="xsm-${VERSION}.tar.bz2"

DEPENDS=(
  libxaw
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
cce867ff7d0df9c0b9e682591779952c
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
  VERSION_STRING='xsm-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/xsm-%version%.tar.bz2'
  )
}
