#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.1"

DIR="zenity-${VERSION}"
TARBALL="zenity-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
)

SRC1=(
  $(gnome_mirrors zenity)
)

MD5SUMS=(
a7ade5ff47716f4328d5e0547596dfb6
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

post_install(){
  gnome_script zenity install || return 1
}

pre_remove(){
  gnome_script zenity remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/zenity/%minor_version%/'
  VERSION_STRING='zenity-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/zenity/%minor_version%/zenity-%version%.tar.bz2'
  )
}
