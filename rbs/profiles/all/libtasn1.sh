#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.5"

DIR="libtasn1-${VERSION}"
TARBALL="libtasn1-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/libtasn1/${TARBALL}
)

MD5SUMS=(
e60b863697713c3d6a59b1e8c6f9b0d1
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/libtasn1/'
  VERSION_STRING='libtasn1-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/libtasn1/libtasn1-%version%.tar.gz'
  )
}
