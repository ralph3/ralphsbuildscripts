#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.3.0"

DIR="videoproto-${VERSION}"
TARBALL="videoproto-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/proto/${TARBALL}
)

MD5SUMS=(
fb762146a18207a1e8bc9f299dfc7ac0
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/proto/'
  VERSION_STRING='videoproto-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/proto/videoproto-%version%.tar.bz2'
  )
}