#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.20.1"

DIR="gtk-engines-${VERSION}"
TARBALL="gtk-engines-${VERSION}.tar.bz2"

DEPENDS=(
  gtk+
)

SRC1=(
  $(gnome_mirrors gtk-engines)
)

MD5SUMS=(
666de7fcdb775cd90dd95e1b20860b5a
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
  gnome_script gtk-engines install || return 1
}

pre_remove(){
  gnome_script gtk-engines remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gtk-engines/%minor_version%/'
  VERSION_STRING='gtk-engines-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gtk-engines/%minor_version%/gtk-engines-%version%.tar.bz2'
  )
}