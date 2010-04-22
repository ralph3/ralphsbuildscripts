#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="gnome-panel-${VERSION}"
TARBALL="gnome-panel-${VERSION}.tar.bz2"

DEPENDS=(
  gnome-desktop
  gnome-menus
  libgweather
  libwnck
)

SRC1=(
  $(gnome_mirrors gnome-panel)
)

MD5SUMS=(
7a1ae8f3489c67708e2520823808649f
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/gnome-panel \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script gnome-panel install || return 1
  gconftool-2 --config-source="$(gconftool-2 --get-default-source)" --direct \
    --load /etc/gnome/gconf/schemas/panel-default-setup.entries >&/dev/null
}

pre_remove(){
  gnome_script gnome-panel remove || return 1
  gconftool-2 --config-source="$(gconftool-2 --get-default-source)" --direct \
    --unload /etc/gnome/gconf/schemas/panel-default-setup.entries >&/dev/null
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/gnome-panel/%minor_version%/'
  VERSION_STRING='gnome-panel-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/gnome-panel/%minor_version%/gnome-panel-%version%.tar.bz2'
  )
}
