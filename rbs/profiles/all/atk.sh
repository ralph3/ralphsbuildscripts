#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.30.0"

DIR="atk-${VERSION}"
TARBALL="atk-${VERSION}.tar.bz2"

DEPENDS=(
  glib
)

SRC1=(
  $(gnome_mirrors atk)
)

MD5SUMS=(
548d413775819fef425410739041cac3
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/atk/%minor_version%/'
  VERSION_STRING='atk-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/atk/%minor_version%/atk-%version%.tar.bz2"
  )
}
