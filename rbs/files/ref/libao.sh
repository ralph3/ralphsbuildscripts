#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.8.5"

DIR="libao-${VERSION}"
TARBALL="libao-${VERSION}.tar.gz"

DEPENDS=(
  esound
)

SRC1=(
http://www.xiph.org/ao/src/${TARBALL}
)

MD5SUMS=(
dd72b66f5f29361411bda465470b65e2
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  make CCLD='foo' || return 1 #explain that and your a good one. :/
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.xiph.org/ao/src/'
  VERSION_STRING='libao-%version%.tar.gz'
  MIRRORS=(
    'http://www.xiph.org/ao/src/libao/libao-%version%.tar.gz'
  )
}
