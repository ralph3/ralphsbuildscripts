#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.1"

DIR="liblbxutil-${VERSION}"
TARBALL="liblbxutil-${VERSION}.tar.bz2"

DEPENDS=(
  xextproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
b73cbd5bc3cd268722a624a5f1318fde
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/lib/'
  VERSION_STRING='liblbxutil-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/liblbxutil-%version%.tar.bz2'
  )
}
