#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.8.13"

DIR="libIDL-${VERSION}"
TARBALL="libIDL-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnome.org/pub/GNOME/sources/libIDL/0.8/${TARBALL}
)

MD5SUMS=(
b43b289a859eb38a710f70622c46e571
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/libIDL-config-2 || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnome.org/pub/GNOME/sources/libIDL/%minor_version%/'
  VERSION_STRING='libIDL-%version%.tar.bz2'
  ONLY_EVEN_MINORS=1
  MIRRORS=(
    "http://ftp.gnome.org/pub/GNOME/sources/libIDL/%minor_version%/libIDL-%version%.tar.bz2"
  )
}
