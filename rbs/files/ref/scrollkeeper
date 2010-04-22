#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.3.14"

DIR="scrollkeeper-${VERSION}"
TARBALL="scrollkeeper-${VERSION}.tar.bz2"

DEPENDS=(
  docbook-xml
  libxslt
)

SRC1=(
  $(gnome_mirrors scrollkeeper)
)

MD5SUMS=(
b175e582a6cec3e50a9de73a5bb7455a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var \
    --disable-static --with-omfdirs=/usr/share/omf || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/scrollkeeper-config || return 1
  rm -rf $TMPROOT/var/lib/scrollkeeper/*
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  gnome_script scrollkeeper install || return 1
}

pre_remove(){
  gnome_script scrollkeeper remove || return 1
}

pre_upgrade(){
  pre_remove || return 1
}

post_upgrade(){
  post_install || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/scrollkeeper/%minor_version%/'
  VERSION_STRING='scrollkeeper-%version%.tar.bz2'
  ONLY_EVEN_MINORS=0
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/scrollkeeper/%minor_version%/scrollkeeper-%version%.tar.bz2'
  )
}
