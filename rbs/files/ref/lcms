#!/bin/bash

VERSION="1.19"

DIR="lcms-${VERSION}"
TARBALL="lcms-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.littlecms.com/${TARBALL}
)

MD5SUMS=(
8af94611baf20d9646c7c2c285859818
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
