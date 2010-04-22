#!/bin/bash

VERSION="2.0.1"
SYS_VERSION="2.0.1-2"

DIR="expat-${VERSION}"
TARBALL="expat-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/expat/${TARBALL}
)

MD5SUMS=(
ee8b492592568805593f81f8cdf2a04c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  rm $TMPROOT/usr/$LIBSDIR/*.la || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=10127&package_id=10780'
  VERSION_STRING='expat-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/expat/expat-%version%.tar.gz'
  )
}