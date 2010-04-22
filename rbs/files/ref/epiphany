#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="epiphany-${VERSION}"
TARBALL="epiphany-${VERSION}.tar.bz2"

DEPENDS=(
  xulrunner
)

SRC1=(
  $(gnome_mirrors epiphany)
)

MD5SUMS=(
af51614c7b78f8b8c68e9ece3d8f4d8f
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
  gnome_script epiphany install || return 1
}

pre_remove(){
  gnome_script epiphany remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/epiphany/%minor_version%/'
  VERSION_STRING='epiphany-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/epiphany/%minor_version%/epiphany-%version%.tar.bz2'
  )
}
