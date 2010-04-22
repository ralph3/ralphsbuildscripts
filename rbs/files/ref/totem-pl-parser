#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="totem-pl-parser-${VERSION}"
TARBALL="totem-pl-parser-${VERSION}.tar.bz2"

DEPENDS=(
  evolution-data-server
)

SRC1=(
  $(gnome_mirrors totem-pl-parser)
)

MD5SUMS=(
f63f3a7743b7ec5b1115d3866461ce30
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script totem-pl-parser install || return 1
}

pre_remove(){
  gnome_script totem-pl-parser remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/totem-pl-parser/%minor_version%/'
  VERSION_STRING='totem-pl-parser-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/totem-pl-parser/%minor_version%/totem-pl-parser-%version%.tar.bz2'
  )
}
