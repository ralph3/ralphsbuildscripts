#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.18"

DIR="libsndfile-${VERSION}"
TARBALL="libsndfile-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.mega-nerd.com/libsndfile/${TARBALL}
)

MD5SUMS=(
9fde6efb1b75ef38398acf856f252416
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
  ADDRESS='http://www.mega-nerd.com/libsndfile/'
  VERSION_STRING='libsndfile-%version%.tar.gz'
  MIRRORS=(
    "http://www.mega-nerd.com/libsndfile/libsndfile-%version%.tar.gz"
  )
}
