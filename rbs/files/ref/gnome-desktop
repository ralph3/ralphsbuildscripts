#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="gnome-desktop-${VERSION}"
TARBALL="gnome-desktop-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-doc-utils
  libgnomeui
  startup-notification
)

SRC1=(
  $(gnome_mirrors gnome-desktop)
)

MD5SUMS=(
27579963a56d1d35a22e30c21666a500
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin --sysconfdir=/etc/gnome \
    --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-desktop/%minor_version%/'
  VERSION_STRING='gnome-desktop-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-desktop/%minor_version%/gnome-desktop-%version%.tar.bz2'
  )
}
