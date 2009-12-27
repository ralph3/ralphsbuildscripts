#!/bin/bash

VERSION="2.4.17"

DIR="libdrm-${VERSION}"
TARBALL="libdrm-${VERSION}.tar.gz"

DEPENDS=(
  libpthread-stubs
)

SRC1=(
http://dri.freedesktop.org/libdrm/${TARBALL}
)

MD5SUMS=(
6eeeb332ca9d296663bb5b38ab362013
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
  ADDRESS='http://dri.freedesktop.org/libdrm/'
  VERSION_STRING='libdrm-%version%.tar.gz'
  ##ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://dri.freedesktop.org/libdrm/libdrm-%version%.tar.gz'
  )
}
