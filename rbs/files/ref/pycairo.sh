#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.8.8"

DIR="pycairo-${VERSION}"
TARBALL="pycairo-${VERSION}.tar.gz"

DEPENDS=(
  cairo
)

SRC1=(
http://cairographics.org/releases/${TARBALL}
)

MD5SUMS=(
054da6c125cb427a003f5fd6c54f853e
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
  ADDRESS='http://cairographics.org/releases/'
  VERSION_STRING='pycairo-%version%.tar.gz'
  MIRRORS=(
    'http://cairographics.org/releases/pycairo-%version%.tar.gz'
  )
}