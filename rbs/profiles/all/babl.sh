#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.0.22"

DIR="babl-${VERSION}"
TARBALL="babl-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.gtk.org/pub/babl/$(cut -f-2 -d'.' <<< $VERSION)/${TARBALL}
)

MD5SUMS=(
b821ce696b40feb74552da9d666defad
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.gtk.org/pub/babl/%minor_version%/'
  VERSION_STRING='babl-%version%.tar.bz2'
  MINOR_VERSION='0.0'
  MIRRORS=(
    'ftp://ftp.gtk.org/pub/babl/%minor_version%/babl-%version%.tar.bz2'
  )
}
