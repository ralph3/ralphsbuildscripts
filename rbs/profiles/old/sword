#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.5.9"


DIR="sword-${VERSION}"
TARBALL="sword-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://www.crosswire.org/ftpmirror/pub/sword/source/v$(echo $VERSION | cut -f-2 -d'.')/${TARBALL}
)

MD5SUMS=(
e1f1af8c2add8310d0bbcddc9af523b8
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

#version_check_info(){
#  ADDRESS='http://www.crosswire.org/ftpmirror/pub/sword/source/v%minor_version%/'
#  VERSION_STRING='sword-%version%.tar.gz'
#  MIRRORS=(
#    'http://www.crosswire.org/ftpmirror/pub/sword/source/v%minor_version%/sword-%version%.tar.gz'
#  )
#}
