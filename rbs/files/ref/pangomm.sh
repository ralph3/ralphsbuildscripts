#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.14.1"

DIR="pangomm-${VERSION}"
TARBALL="pangomm-${VERSION}.tar.bz2"

DEPENDS=(
  cairomm
  glibmm
  pangomm
)

SRC1=(
  $(gnome_mirrors pangomm)
)

MD5SUMS=(
c67228ea93dd977394d2872b61754b53
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/pangomm/%minor_version%/'
  VERSION_STRING='pangomm-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/pangomm/%minor_version%/pangomm-%version%.tar.bz2'
  )
}
