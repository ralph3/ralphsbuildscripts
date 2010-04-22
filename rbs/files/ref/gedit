#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="gedit-${VERSION}"
TARBALL="gedit-${VERSION}.tar.bz2"

DEPENDS=(
  enchant
  gnome-doc-utils
  gnome-python-desktop
  iso-codes
  libgnomeui
)

SRC1=(
  $(gnome_mirrors gedit)
)

MD5SUMS=(
48ed6c5c156791cffc219a7d7390da57
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
  gnome_script gedit install || return 1
}

pre_remove(){
  gnome_script gedit remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gedit/%minor_version%/'
  VERSION_STRING='gedit-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gedit/%minor_version%/gedit-%version%.tar.bz2'
  )
}
