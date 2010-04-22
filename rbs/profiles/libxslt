#!/bin/bash

VERSION="1.1.22"
SYS_VERSION="1.1.22-1"

DIR="libxslt-${VERSION}"
TARBALL="libxslt-${VERSION}.tar.bz2"

DEPENDS=(
  libxml2
)

SRC1=(
  $(gnome_mirrors libxslt)
)

MD5SUMS=(
f2061dddea77257488601e20e2f3b5a7
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/xslt-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libxslt/%minor_version%/'
  VERSION_STRING='libxslt-%version%.tar.bz2'
  MINOR_VERSION_FILTERS='br'
  MIRRORS=(
    'http://ftp.gnome.org/pub/GNOME/sources/libxslt/%minor_version%/libxslt-%version%.tar.bz2'
  )
}
