#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.9"

DIR="diffutils-${VERSION}"
TARBALL="diffutils-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/diffutils/${TARBALL}
)

MD5SUMS=(
d6bc1bdc874ddb14cfed4d1655a0dbbe
)

Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=${BUILDHOST} \
    --host=${BUILDTARGET} --prefix=$TCDIR || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=${BUILDHOST} \
    --host=${BUILDTARGET} --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/diffutils/'
  VERSION_STRING='diffutils-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/diffutils/diffutils-%version%.tar.gz'
  )
}
