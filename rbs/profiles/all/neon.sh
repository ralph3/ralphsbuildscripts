#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.28.5"

DIR="neon-${VERSION}"
TARBALL="neon-${VERSION}.tar.gz"

DEPENDS=(
  expat
  openssl
)

SRC1=(
http://www.webdav.org/neon/${TARBALL}
)

MD5SUMS=(
8c160bc0e358a3b58645acbba40fe873
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CFLAGS="$CFLAGS -fPIC" \
    CXXFLAGS="$CXXFLAGS -fPIC" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-ssl || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/neon-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.webdav.org/neon/'
  VERSION_STRING='neon-%version%.tar.gz'
  MIRRORS=(
    'http://www.webdav.org/neon/neon-%version%.tar.gz'
  )
}
