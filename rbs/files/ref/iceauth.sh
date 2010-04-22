#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.3"

DIR="iceauth-${VERSION}"
TARBALL="iceauth-${VERSION}.tar.bz2"

DEPENDS=(
  libice
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
975ade3f238c1eb10705da0a91e6e8e7
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
  VERSION_STRING='iceauth-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/iceauth-%version%.tar.bz2'
  )
}