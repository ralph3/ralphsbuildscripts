#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.2.3"

DIR="libsigc++-${VERSION}"
TARBALL="libsigc++-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors libsigc++)
)

MD5SUMS=(
f4574b343eebc4bff66a9e1e5ce6e490
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libsigc++/%minor_version%/'
  VERSION_STRING='libsigc++-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libsigc++/%minor_version%/libsigc++-%version%.tar.bz2'
  )
}
