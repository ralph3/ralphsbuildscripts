#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.8.90"

DIR="icon-naming-utils-${VERSION}"
TARBALL="icon-naming-utils-${VERSION}.tar.gz"

DEPENDS=(
  perl-xml-simple
)

SRC1=(
http://tango.freedesktop.org/releases/${TARBALL}
)

MD5SUMS=(
2c5c7a418e5eb3268f65e21993277fba
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://tango.freedesktop.org/releases/'
  VERSION_STRING='icon-naming-utils-%version%.tar.gz'
  MIRRORS=(
    'http://tango.freedesktop.org/releases/icon-naming-utils-%version%.tar.gz'
  )
}
