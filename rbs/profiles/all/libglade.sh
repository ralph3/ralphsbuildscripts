#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.4"

DIR="libglade-${VERSION}"
TARBALL="libglade-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
)

SRC1=(
  $(gnome_mirrors libglade)
)

MD5SUMS=(
d1776b40f4e166b5e9c107f1c8fe4139
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libglade/%minor_version%/'
  VERSION_STRING='libglade-%version%.tar.bz2'
  ONLY_EVEN_MINORS=0
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/libglade/%minor_version%/libglade-%version%.tar.bz2"
  )
}
