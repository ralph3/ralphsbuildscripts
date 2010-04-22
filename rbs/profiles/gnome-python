#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.28.1"

DIR="gnome-python-${VERSION}"
TARBALL="gnome-python-${VERSION}.tar.bz2"

DEPENDS=(
  pygtk
  libgnome
)

SRC1=(
  $(gnome_mirrors gnome-python)
)

MD5SUMS=(
a17ad952813ed86f520de8e07194a2bf
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --libexecdir=/usr/sbin \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-python/%minor_version%/'
  VERSION_STRING='gnome-python-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/gnome-python/%minor_version%/gnome-python-%version%.tar.bz2"
  )
}
