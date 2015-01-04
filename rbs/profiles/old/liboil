#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.3.15"

DIR="liboil-${VERSION}"
TARBALL="liboil-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://liboil.freedesktop.org/download/${TARBALL}
)

MD5SUMS=(
11dd39b1ca13ce2e0618d4df8303f137
)

build(){
  local CONF
  CONF=
  [ "$SYSTYPE" == "MULTILIB" ] && [ "$BUILD" == "$BUILD32" ] && {
    CONF="--build=$BUILDTARGET"
  }
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure $CONF --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://liboil.freedesktop.org/download/'
  VERSION_STRING='liboil-%version%.tar.gz'
  MIRRORS=(
    "http://liboil.freedesktop.org/download/liboil-%version%.tar.gz"
  )
}
