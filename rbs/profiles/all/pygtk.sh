#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.16.0"

DIR="pygtk-${VERSION}"
TARBALL="pygtk-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
  pycairo
  pygobject
)

SRC1=(
  $(gnome_mirrors pygtk)
)

MD5SUMS=(
bd0d437fefd6d5390f5d770a495cd50c
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/pygtk/%minor_version%/'
  VERSION_STRING='pygtk-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/pygtk/%minor_version%/pygtk-%version%.tar.bz2"
  )
}
