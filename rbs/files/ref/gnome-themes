#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="gnome-themes-${VERSION}"
TARBALL="gnome-themes-${VERSION}.tar.bz2"

DEPENDS=(
  gtk-engines
)

SRC1=(
  $(gnome_mirrors gnome-themes)
)

MD5SUMS=(
c986db988da6ca6dcf1032c1c9736e29
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
  gnome_script gnome-themes install || return 1
}

pre_remove(){
  gnome_script gnome-themes remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-themes/%minor_version%/'
  VERSION_STRING='gnome-themes-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-themes/%minor_version%/gnome-themes-%version%.tar.bz2'
  )
}
