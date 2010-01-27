#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2"

DIR="cabextract-${VERSION}"
TARBALL="cabextract-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.cabextract.org.uk/${TARBALL}
)

MD5SUMS=(
dc421a690648b503265c82ade84e143e
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.cabextract.org.uk/'
  VERSION_STRING='cabextract-%version%.tar.gz'
  MIRRORS=(
    'http://www.cabextract.org.uk/cabextract-%version%.tar.gz'
  )
}
