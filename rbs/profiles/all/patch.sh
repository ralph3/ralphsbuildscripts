#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.5.9"

DIR="patch-${VERSION}"
TARBALL="patch-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://alpha.gnu.org/gnu/diffutils/${TARBALL}
)

MD5SUMS=(
dacfb618082f8d3a2194601193cf8716
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
  make install prefix=$TMPROOT/usr || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://alpha.gnu.org/gnu/diffutils/'
  VERSION_STRING='patch-%version%.tar.gz'
  MIRRORS=(
    'ftp://alpha.gnu.org/gnu/diffutils/patch-%version%.tar.gz'
  )
}
