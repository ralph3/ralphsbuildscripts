#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.8.1"

DIR="diffutils-${VERSION}"
TARBALL="diffutils-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/diffutils/${TARBALL}
)

MD5SUMS=(
71f9c5ae19b60608f6c7f162da86a428
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=${BUILDHOST} \
    --host=${BUILDTARGET} --prefix=/RBS-Tools || return 1
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
