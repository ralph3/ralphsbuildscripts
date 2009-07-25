#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.26.0"

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
36a4e5e1b2c7c053779a9a399f6146a2
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
