#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.4.1"

DIR="mpeg2dec-${VERSION}"
TARBALL="mpeg2dec-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://libmpeg2.sourceforge.net/files/${TARBALL}
)

MD5SUMS=(
7631b0a4bcfdd0d78c0bb0083080b0dc
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --x-libraries=/usr/$LIBSDIR \
    --enable-shared || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://libmpeg2.sourceforge.net/files/'
  VERSION_STRING='mpeg2dec-%version%.tar.gz'
  VERSION_FILTERS="snapshot"
  MIRRORS=(
    "http://libmpeg2.sourceforge.net/files/mpeg2dec-%version%.tar.gz"
  )
}
