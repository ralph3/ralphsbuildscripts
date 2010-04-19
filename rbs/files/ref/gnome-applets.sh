#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3.1"

DIR="gnome-applets-${VERSION}"
TARBALL="gnome-applets-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-icon-theme
  gnome-panel
  gst-plugins-base
  libgtop
  libxklavier
)

SRC1=(
  $(gnome_mirrors gnome-applets)
)

MD5SUMS=(
9d60394e9feedb754838e5087ddaee97
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnome-applets \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-applets install || return 1
}

pre_remove(){
  gnome_script gnome-applets remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-applets/%minor_version%/'
  VERSION_STRING='gnome-applets-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-applets/%minor_version%/gnome-applets-%version%.tar.bz2'
  )
}
