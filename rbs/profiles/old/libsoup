#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.24.3"

DIR="libsoup-${VERSION}"
TARBALL="libsoup-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors libsoup)
)

MD5SUMS=(
118967f097a7e1e9d5023f1f06e0b65a
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
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libsoup/%minor_version%/'
  VERSION_STRING='libsoup-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libsoup/%minor_version%/libsoup-%version%.tar.bz2'
  )
}
