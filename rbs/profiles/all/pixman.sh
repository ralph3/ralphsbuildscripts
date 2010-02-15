#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.17.6"

DIR="pixman-${VERSION}"
TARBALL="pixman-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
643093dac601ee37f88ef73849c2f46b
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
  VERSION_STRING='pixman-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/pixman-%version%.tar.bz2'
  )
}
