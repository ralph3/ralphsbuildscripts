#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.3"

DIR="dri2proto-${VERSION}"
TARBALL="dri2proto-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/proto/${TARBALL}
)

MD5SUMS=(
3407b494d5e90d584c9af52aa8f9f028
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
  VERSION_STRING='dri2proto-%version%.tar.bz2'
  VERSION_FILTERS='\.99'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/proto/dri2proto-%version%.tar.bz2'
  )
}
