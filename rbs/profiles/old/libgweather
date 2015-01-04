#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="libgweather-${VERSION}"
TARBALL="libgweather-${VERSION}.tar.bz2"

DEPENDS=(
  libsoup
)

SRC1=(
  $(gnome_mirrors libgweather)
)

MD5SUMS=(
ab29ea93a87339bb1571434fe2086789
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR \
    --sysconfdir=/etc/gnome --localstatedir=/var/lib || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libgweather/%minor_version%/'
  VERSION_STRING='libgweather-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libgweather/%minor_version%/libgweather-%version%.tar.bz2'
  )
}
