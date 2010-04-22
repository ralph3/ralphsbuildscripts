#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.10"

DIR="libdvdcss-${VERSION}"
TARBALL="libdvdcss-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://download.videolan.org/pub/libdvdcss/$VERSION/${TARBALL}
)

MD5SUMS=(
ebd5370b79ac5a83e5c61b24a214cf74
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://download.videolan.org/pub/libdvdcss/%version%/'
  VERSION_STRING='libdvdcss-%version%.tar.bz2'
  MIRRORS=(
    'http://download.videolan.org/pub/libdvdcss/%version%/libdvdcss-%version%.tar.bz2'
  )
}
