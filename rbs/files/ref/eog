#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3.1"

DIR="eog-${VERSION}"
TARBALL="eog-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-desktop
  lcms
  libgnomeprintui
)

SRC1=(
  $(gnome_mirrors eog)
)

MD5SUMS=(
8c303bc4e10f88c7bbd18ecf539731fe
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
  gnome_script eog install || return 1
}

pre_remove(){
  gnome_script eog remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/eog/%minor_version%/'
  VERSION_STRING='eog-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/eog/%minor_version%/eog-%version%.tar.bz2'
  )
}
