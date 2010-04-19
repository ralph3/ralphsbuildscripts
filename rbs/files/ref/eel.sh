#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.1"

DIR="eel-${VERSION}"
TARBALL="eel-${VERSION}.tar.bz2"

DEPENDS=(
  gail
  gnome-desktop
  gnome-menus
)

SRC1=(
  $(gnome_mirrors eel)
)

MD5SUMS=(
b591df36af8f1b23dd175be33b5de073
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/eel/%minor_version%/'
  VERSION_STRING='eel-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/eel/%minor_version%/eel-%version%.tar.bz2'
  )
}
