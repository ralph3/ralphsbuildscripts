#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.24.0"

DIR="vte-${VERSION}"
TARBALL="vte-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
  ncurses
)

SRC1=(
  $(gnome_mirrors vte)
)

MD5SUMS=(
c381f6019448a6e84470ec0acfd78c63
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/vte || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/vte/%minor_version%/'
  VERSION_STRING='vte-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/vte/%minor_version%/vte-%version%.tar.bz2"
  )
}