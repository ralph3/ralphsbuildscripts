#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.2"

DIR="xlsfonts-${VERSION}"
TARBALL="xlsfonts-${VERSION}.tar.bz2"

DEPENDS=(
  libx11
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
28958248590ff60ecd70e8f590d977b7
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
  VERSION_STRING='xlsfonts-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/xlsfonts-%version%.tar.bz2'
  )
}
