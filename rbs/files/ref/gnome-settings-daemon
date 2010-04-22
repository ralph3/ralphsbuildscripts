#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.1"

DIR="gnome-settings-daemon-${VERSION}"
TARBALL="gnome-settings-daemon-${VERSION}.tar.bz2"

DEPENDS=(
  gtkmm
  libgnomekbd
)

SRC1=(
  $(gnome_mirrors gnome-settings-daemon)
)

MD5SUMS=(
841447fa690a3a4712e9ddaec2584824
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnome-settings-daemon \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-settings-daemon install || return 1
}

pre_remove(){
  gnome_script gnome-settings-daemon remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-settings-daemon/%minor_version%/'
  VERSION_STRING='gnome-settings-daemon-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-settings-daemon/%minor_version%/gnome-settings-daemon-%version%.tar.bz2'
  )
}
