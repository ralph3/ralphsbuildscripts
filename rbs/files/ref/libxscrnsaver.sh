#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.0"

DIR="libXScrnSaver-${VERSION}"
TARBALL="libXScrnSaver-${VERSION}.tar.bz2"

DEPENDS=(
  scrnsaverproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
33e54f64b55f22d8bbe822a5b62568cb
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
  VERSION_STRING='libXScrnSaver-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-%version%.tar.bz2'
  )
}