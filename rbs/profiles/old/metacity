#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0"

DIR="metacity-${VERSION}"
TARBALL="metacity-${VERSION}.tar.bz2"

DEPENDS=(
  desktop-file-utils
  startup-notification
)

SRC1=(
  $(gnome_mirrors metacity)
)

MD5SUMS=(
d4aa782d5f71b6c42514b239684a4aa3
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/metacity \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script metacity install || return 1
}

pre_remove(){
  gnome_script metacity remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/metacity/%minor_version%/'
  VERSION_STRING='metacity-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/metacity/%minor_version%/metacity-%version%.tar.bz2'
  )
}
