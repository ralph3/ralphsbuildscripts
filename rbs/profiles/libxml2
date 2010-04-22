#!/bin/bash

VERSION="2.7.7"

DIR="libxml2-${VERSION}"
TARBALL="libxml2-${VERSION}.tar.gz"

DEPENDS=(
  python
  readline
)

SRC1=(
ftp://xmlsoft.org/libxml2/${TARBALL}
)

MD5SUMS=(
9abc9959823ca9ff904f1fbcf21df066
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-history || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/xml2-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://xmlsoft.org/libxml2/'
  VERSION_STRING='libxml2-%version%.tar.gz'
  VERSION_FILTERS='tests sources snap'
  MIRRORS=(
    'ftp://xmlsoft.org/libxml2/libxml2-%version%.tar.gz'
  )
}
