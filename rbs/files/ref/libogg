#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.3"

DIR="libogg-${VERSION}"
TARBALL="libogg-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://downloads.xiph.org/releases/ogg/${TARBALL}
)

MD5SUMS=(
eaf7dc6ebbff30975de7527a80831585
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
  ADDRESS='http://downloads.xiph.org/releases/ogg/'
  VERSION_STRING='libogg-%version%.tar.gz'
  VERSION_FILTERS='beta rc'
  MIRRORS=(
    'http://downloads.xiph.org/releases/ogg/libogg-%version%.tar.gz'
  )
}
