#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.14.3"

DIR="gtkmm-${VERSION}"
TARBALL="gtkmm-${VERSION}.tar.bz2"

DEPENDS=(
  cairomm
  glibmm
  pangomm
)

SRC1=(
  $(gnome_mirrors gtkmm)
)

MD5SUMS=(
10039f35d7f815d47f926a13cefe65d6
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gtkmm/%minor_version%/'
  VERSION_STRING='gtkmm-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gtkmm/%minor_version%/gtkmm-%version%.tar.bz2'
  )
}
