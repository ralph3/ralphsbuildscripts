#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.15"

DIR="popt-${VERSION}"
TARBALL="popt-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://rpm5.org/files/popt/${TARBALL}
)

MD5SUMS=(
c61ef795fa450eb692602a661ec8d7f1
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install usrlibdir=/usr/$LIBSDIR DESTDIR=$TMPROOT || return 1
  rm $TMPROOT/usr/$LIBSDIR/*.la* || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://rpm5.org/files/popt/'
  VERSION_STRING='popt-%version%.tar.gz'
  MIRRORS=(
    'http://rpm5.org/files/popt/popt-%version%.tar.gz'
  )
}
