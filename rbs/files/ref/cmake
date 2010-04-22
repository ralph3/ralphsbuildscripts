#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.4.8"

DIR="cmake-${VERSION}"
TARBALL="cmake-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.cmake.org/files/v$(echo $VERSION | cut -f-2 -d'.')/${TARBALL}
)

MD5SUMS=(
f5dd061c31765a49dc17ae8bdc986779
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
  ADDRESS='http://www.cmake.org/files/v2.4/'
  VERSION_STRING='cmake-%version%.tar.gz'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://www.cmake.org/files/v2.4/cmake-%version%.tar.gz'
  )
}
