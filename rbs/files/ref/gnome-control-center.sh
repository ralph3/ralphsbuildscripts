#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.0.1"

DIR="gnome-control-center-${VERSION}"
TARBALL="gnome-control-center-${VERSION}.tar.bz2"

DEPENDS=(
  gconf
  gnome-desktop
  gnome-doc-utils
  gnome-menus
  gnome-panel
  gnome-settings-daemon
  gst-plugins-base
  gtk+
  libcanberra
  libgnomekbd
  libgnomeui
  libxklavier
  metacity
  nautilus
  perl-xml-parser
)

SRC1=(
  $(gnome_mirrors gnome-control-center)
)

MD5SUMS=(
dcaf6e91fddbb1d57d045a4de34ec25c
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnome-control-center \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-control-center install || return 1
}

pre_remove(){
  gnome_script gnome-control-center remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-control-center/%minor_version%/'
  VERSION_STRING='gnome-control-center-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-control-center/%minor_version%/gnome-control-center-%version%.tar.bz2'
  )
}
