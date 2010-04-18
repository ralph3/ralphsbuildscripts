#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.18.0"


DIR="gnome-mime-data-${VERSION}"
TARBALL="gnome-mime-data-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors gnome-mime-data)
)

MD5SUMS=(
541858188f80090d12a33b5a7c34d42c
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-mime-data/%minor_version%/'
  VERSION_STRING='gnome-mime-data-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-mime-data/%minor_version%/gnome-mime-data-%version%.tar.bz2'
  )
}