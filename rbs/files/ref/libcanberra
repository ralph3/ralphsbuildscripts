#!/bin/bash

VERSION="0.11"

DIR="libcanberra-${VERSION}"
TARBALL="libcanberra-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://0pointer.de/lennart/projects/libcanberra/${TARBALL}
)

MD5SUMS=(
c661db14cb0b1fe9b6963defacc3bba6
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://0pointer.de/lennart/projects/libcanberra/'
  VERSION_STRING='libcanberra-%version%.tar.gz'
  MIRRORS=(
    'http://0pointer.de/lennart/projects/libcanberra/libcanberra-%version%.tar.gz'
  )
}
