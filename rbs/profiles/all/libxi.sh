#!/bin/bash

VERSION="1.2.1"

DIR="libXi-${VERSION}"
TARBALL="libXi-${VERSION}.tar.bz2"

DEPENDS=(
  libxext
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
cfb36307e8e7ffafe40848dba24e0b11
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/lib/'
  VERSION_STRING='libXi-%version%.tar.bz2'
  VERSION_FILTERS='99'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXi-%version%.tar.bz2'
  )
}
