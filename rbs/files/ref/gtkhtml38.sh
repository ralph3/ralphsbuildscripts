#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.8.2"


DIR="gtkhtml-${VERSION}"
TARBALL="gtkhtml-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
)

SRC1=(
  $(gnome_mirrors gtkhtml)
)

MD5SUMS=(
4455e24142cc914f00f1e8b81940df68
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gtkhtml/%minor_version%/'
  VERSION_STRING='gtkhtml-%version%.tar.bz2'
  MINOR_VERSION="3.8"
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gtkhtml/%minor_version%/gtkhtml-%version%.tar.bz2'
  )
}
