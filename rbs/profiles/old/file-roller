#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="file-roller-${VERSION}"
TARBALL="file-roller-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors file-roller)
)

MD5SUMS=(
20264b13cd27c6542c8289256d768c9c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/file-roller \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script file-roller install || return 1
}

pre_remove(){
  gnome_script file-roller remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/file-roller/%minor_version%/'
  VERSION_STRING='file-roller-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/file-roller/%minor_version%/file-roller-%version%.tar.bz2'
  )
}
