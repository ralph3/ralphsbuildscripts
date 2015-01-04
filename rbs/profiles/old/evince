#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.2"

DIR="evince-${VERSION}"
TARBALL="evince-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-icon-theme
  nautilus
  poppler
)

SRC1=(
  $(gnome_mirrors evince)
)

MD5SUMS=(
f0f9e06a93516b238ee24ac38d68b57c
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
  gnome_script evince install || return 1
}

pre_remove(){
  gnome_script evince remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/evince/%minor_version%/'
  VERSION_STRING='evince-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/evince/%minor_version%/evince-%version%.tar.bz2'
  )
}
