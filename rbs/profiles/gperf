#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.0.4"

DIR="gperf-${VERSION}"
TARBALL="gperf-${VERSION}.tar.gz"

DEPENDS=(
  m4
)

SRC1=(
http://ftp.gnu.org/gnu/gperf/${TARBALL}
)

MD5SUMS=(
c1f1db32fb6598d6a93e6e88796a8632
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
  ADDRESS='http://ftp.gnu.org/gnu/gperf/'
  VERSION_STRING='gperf-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gperf/gperf-%version%.tar.gz'
  )
}
