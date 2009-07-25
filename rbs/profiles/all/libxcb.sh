#!/bin/bash

VERSION="1.4"

DIR="libxcb-${VERSION}"
TARBALL="libxcb-${VERSION}.tar.bz2"

DEPENDS=(
  libxslt
  libpthread-stubs
  xcb-proto
)

SRC1=(
http://xcb.freedesktop.org/dist/${TARBALL}
)

MD5SUMS=(
b00fd506c717dea01f595e8da31f6914
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
  ADDRESS='http://xcb.freedesktop.org/dist/'
  VERSION_STRING='libxcb-%version%.tar.bz2'
  MIRRORS=(
    'http://xcb.freedesktop.org/dist/libxcb-%version%.tar.bz2'
  )
}
