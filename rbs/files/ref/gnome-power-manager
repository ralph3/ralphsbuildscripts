#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.4"

DIR="gnome-power-manager-${VERSION}"
TARBALL="gnome-power-manager-${VERSION}.tar.bz2"

DEPENDS=(
  policykit-gnome
)

SRC1=(
  $(gnome_mirrors gnome-power-manager)
)

MD5SUMS=(
bad8bba644d31f88d92a11d8880feada
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-power-manager/%minor_version%/'
  VERSION_STRING='gnome-power-manager-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-power-manager/%minor_version%/gnome-power-manager-%version%.tar.bz2'
  )
}
