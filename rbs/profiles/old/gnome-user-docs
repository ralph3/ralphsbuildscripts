#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.2"

DIR="gnome-user-docs-${VERSION}"
TARBALL="gnome-user-docs-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors gnome-user-docs)
)

MD5SUMS=(
c387144f39c05152bb0771ae2b07a4d8
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
  gnome_script gnome-user-docs install || return 1
}

pre_remove(){
  gnome_script gnome-user-docs remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-user-docs/%minor_version%/'
  VERSION_STRING='gnome-user-docs-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-user-docs/%minor_version%/gnome-user-docs-%version%.tar.bz2'
  )
}
