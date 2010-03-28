#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.28.2"

DIR="libsoup-${VERSION}"
TARBALL="libsoup-${VERSION}.tar.bz2"

DEPENDS=(
  gnutls
)

SRC1=(
  $(gnome_mirrors libsoup)
)

MD5SUMS=(
31d7ad416005eed4b78f07ac01b6b9f0
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR \
    --sysconfdir=/etc --localstatedir=/var/lib --without-gnome || return 1
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
