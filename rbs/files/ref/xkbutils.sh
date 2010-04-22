#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.2"

DIR="xkbutils-${VERSION}"
TARBALL="xkbutils-${VERSION}.tar.bz2"

DEPENDS=(
  libxaw
  libxkbfile
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
369a21641b7ca983d6641298e51d97f8
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
  VERSION_STRING='xkbutils-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/xkbutils-%version%.tar.bz2'
  )
}