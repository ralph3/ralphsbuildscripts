#!/bin/bash

DISABLE_MULTILIB=1

VERSION="14.1.0"

DIR="sox-${VERSION}"
TARBALL="sox-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/sox/${TARBALL}
)

MD5SUMS=(
b8e2cb3d615d3830347a0948dd8b74a8
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/sox/'
  VERSION_STRING='sox-%version%.tar.gz'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/sox/sox-%version%.tar.gz'
  )
}
