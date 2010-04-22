#!/bin/bash

VERSION="1.0.23"

DIR="alsa-lib-${VERSION}"
TARBALL="alsa-lib-${VERSION}.tar.bz2"

DEPENDS=(
  python
)

SRC1=(
http://ftp.silug.org/pub/alsa/lib/${TARBALL}
ftp://ftp.alsa-project.org/pub/lib/${TARBALL}
)

MD5SUMS=(
f48b50421d8a69d2d806d9c47e534f0d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.silug.org/pub/alsa/lib/'
  VERSION_STRING='alsa-lib-%version%.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://ftp.silug.org/pub/alsa/lib/alsa-lib-%version%.tar.bz2'
  )
}