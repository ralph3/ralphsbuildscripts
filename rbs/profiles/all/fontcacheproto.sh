#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.1.2"

DIR="fontcacheproto-${VERSION}"
TARBALL="fontcacheproto-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/proto/${TARBALL}
)

MD5SUMS=(
60df6b625074a9790e28543dcea71651
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
  VERSION_STRING='fontcacheproto-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/proto/fontcacheproto-%version%.tar.bz2'
  )
}
