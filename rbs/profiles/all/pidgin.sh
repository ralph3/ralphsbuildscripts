#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.6.5"

DIR="pidgin-${VERSION}"
TARBALL="pidgin-${VERSION}.tar.bz2"

DEPENDS=(
  gnutls
  gtkspell
  perl-xml-parser
  startup-notification
)

SRC1=(
http://prdownloads.sourceforge.net/pidgin/${TARBALL}
)

MD5SUMS=(
90847ed22ec830db5d9768748812b661
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc/gnome --disable-meanwhile \
    --disable-avahi --disable-nm --disable-tcl \
    --disable-gstreamer --disable-idn --disable-nss || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script pidgin install || return 1
}

pre_remove(){
  gnome_script pidgin remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://www.pidgin.im/download/source/'
  VERSION_STRING='pidgin-%version%.tar.bz2'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/pidgin/pidgin-%version%.tar.bz2'
  )
}
