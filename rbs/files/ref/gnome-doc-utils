#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.20.0"

DIR="gnome-doc-utils-${VERSION}"
TARBALL="gnome-doc-utils-${VERSION}.tar.bz2"

DEPENDS=(
  scrollkeeper
)

SRC1=(
  $(gnome_mirrors gnome-doc-utils)
)

MD5SUMS=(
fb0e687e0270eff4bbeb6df7091f72b3
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
  gnome_script gnome-doc-utils install || return 1
}

pre_remove(){
  gnome_script gnome-doc-utils remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-doc-utils/%minor_version%/'
  VERSION_STRING='gnome-doc-utils-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-doc-utils/%minor_version%/gnome-doc-utils-%version%.tar.bz2'
  )
}
