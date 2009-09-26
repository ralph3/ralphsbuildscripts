#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.20.0"

DIR="pygobject-${VERSION}"
TARBALL="pygobject-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnome_mirrors pygobject)
)

MD5SUMS=(
10e1fb79be3d698476a28b1e1b0c5640
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/pygobject/%minor_version%/'
  VERSION_STRING='pygobject-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/pygobject/%minor_version%/pygobject-%version%.tar.bz2"
  )
}
