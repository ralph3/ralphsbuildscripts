#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.30.1"

DIR="gnome-icon-theme-${VERSION}"
TARBALL="gnome-icon-theme-${VERSION}.tar.bz2"

DEPENDS=(
  hicolor-icon-theme
  icon-naming-utils
)

SRC1=(
  $(gnome_mirrors gnome-icon-theme)
)

MD5SUMS=(
ffab20f9be63e2ac0a08eb65215bb647
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/%minor_version%/'
  VERSION_STRING='gnome-icon-theme-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/%minor_version%/gnome-icon-theme-%version%.tar.bz2'
  )
}