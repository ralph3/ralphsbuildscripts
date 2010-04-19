#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="totem-${VERSION}"
TARBALL="totem-${VERSION}.tar.bz2"

DEPENDS=(
  gst-plugins-base
  gst-plugins-good
  gst-plugins-bad
  gst-plugins-ugly
  iso-codes
  libxtst
  nautilus
  totem-pl-parser
)

SRC1=(
  $(gnome_mirrors totem)
)

MD5SUMS=(
261bae2586c3bb6a55bfa2704d7e3b14
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR/totem \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib \
    --enable-gstreamer --disable-xine || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script totem install || return 1
}

pre_remove(){
  gnome_script totem remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/totem/%minor_version%/'
  VERSION_STRING='totem-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/totem/%minor_version%/totem-%version%.tar.bz2'
  )
}
