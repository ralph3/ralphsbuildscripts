#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.30.0"

DIR="libwnck-${VERSION}"
TARBALL="libwnck-${VERSION}.tar.bz2"

DEPENDS=(
  startup-notification
)

SRC1=(
  $(gnome_mirrors libwnck)
)

MD5SUMS=(
ed79955dabb606ee0e6d112a291005ad
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
  gnome_script libwnck install || return 1
}

pre_remove(){
  gnome_script libwnck remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libwnck/%minor_version%/'
  VERSION_STRING='libwnck-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libwnck/%minor_version%/libwnck-%version%.tar.bz2'
  )
}
