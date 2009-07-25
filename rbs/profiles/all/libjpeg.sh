#!/bin/bash

VERSION="7"
SYS_VERSION="7-3"

DIR="jpeg-${VERSION}"
TARBALL="jpegsrc.v${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.ijg.org/files/${TARBALL}
ftp://ftp.uu.net/graphics/jpeg/${TARBALL}
)

MD5SUMS=(
382ef33b339c299b56baf1296cda9785
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --enable-static --enable-shared || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.ijg.org/files/'
  VERSION_STRING='jpegsrc.v%version%.tar.gz'
  MIRRORS=(
    'http://www.ijg.org/files/jpegsrc.v%version%.tar.gz'
  )
}
