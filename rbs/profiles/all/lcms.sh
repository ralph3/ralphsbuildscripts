#!/bin/bash

VERSION="1.18a"
SYS_VERSION="1.18a-2"

DIR="lcms-1.18"
TARBALL="lcms-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.littlecms.com/${TARBALL}
)

MD5SUMS=(
f4abfe1c57ea3f633c2e9d034e74e3e8
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  install -v -m755 -d  $TMPROOT/usr/share/doc/lcms-${VERSION}
  install -v -m644 doc/*  $TMPROOT/usr/share/doc/lcms-${VERSION}
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.littlecms.com/downloads.htm'
  VERSION_STRING='lcms-%version%.tar.gz'
  VERSION_FILTERS='mac'
  MIRRORS=(
    'http://www.littlecms.com/lcms-%version%.tar.gz'
  )
}
