#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.3.20"

DIR="libart_lgpl-${VERSION}"
TARBALL="libart_lgpl-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnome.org/pub/GNOME/sources/libart_lgpl/2.3/${TARBALL}
)

MD5SUMS=(
d0ce67f2ebcef1e51a83136c69242a73
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/libart2-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libart_lgpl/%minor_version%/'
  VERSION_STRING='libart_lgpl-%version%.tar.bz2'
  ONLY_EVEN_MINORS=0
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/libart_lgpl/%minor_version%/libart_lgpl-%version%.tar.bz2"
  )
}
