#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.1"

DIR="bdftopcf-${VERSION}"
TARBALL="bdftopcf-${VERSION}.tar.bz2"

DEPENDS=(
  libxfont
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
9685fab33d39954ab8a0d22e0969d5a4 
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/app/'
  VERSION_STRING='bdftopcf-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/bdftopcf-%version%.tar.bz2'
  )
}
