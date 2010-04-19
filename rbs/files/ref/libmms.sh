#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.4"

DIR="libmms-${VERSION}"
TARBALL="libmms-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/libmms/${TARBALL}
)

MD5SUMS=(
4a681a815186fe26bb1b02ccea57fb75
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
  ADDRESS='http://prdownloads.sourceforge.net/libmms/'
  VERSION_STRING='libmms-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/libmms/libmms-%version%.tar.gz"
  )
}
