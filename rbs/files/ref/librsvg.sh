#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.26.2"

DIR="librsvg-${VERSION}"
TARBALL="librsvg-${VERSION}.tar.bz2"

DEPENDS=(
  pango
)

SRC1=(
  $(gnome_mirrors librsvg)
)

MD5SUMS=(
6bb1993f9180176e45d6084089f47aa8
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc \
    --disable-mozilla-plugin || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

post_install(){
  setup-gtk || return 1
}

post_upgrade(){
  post_install
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/librsvg/%minor_version%/'
  VERSION_STRING='librsvg-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/librsvg/%minor_version%/librsvg-%version%.tar.bz2'
  )
}