#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.18.1"

DIR="glibmm-${VERSION}"
TARBALL="glibmm-${VERSION}.tar.bz2"

DEPENDS=(
  glib
  libsigc++
)

SRC1=(
  $(gnome_mirrors glibmm)
)

MD5SUMS=(
942290a4b77dac3ea18a5b70373fe04c
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/glibmm/%minor_version%/'
  VERSION_STRING='glibmm-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/glibmm/%minor_version%/glibmm-%version%.tar.bz2'
  )
}
