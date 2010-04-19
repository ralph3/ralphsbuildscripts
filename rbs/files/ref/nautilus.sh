#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.2"

DIR="nautilus-${VERSION}"
TARBALL="nautilus-${VERSION}.tar.bz2"

DEPENDS=(
  eel
  libexif
  librsvg
  shared-mime-info
)

SRC1=(
  $(gnome_mirrors nautilus)
)

MD5SUMS=(
783e5f7be6391d6c46b4725e38af475a
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
  gnome_script nautilus install || return 1
}

pre_remove(){
  gnome_script nautilus remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/nautilus/%minor_version%/'
  VERSION_STRING='nautilus-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/nautilus/%minor_version%/nautilus-%version%.tar.bz2'
  )
}
