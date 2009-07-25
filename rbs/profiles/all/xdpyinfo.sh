#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.3"

DIR="xdpyinfo-${VERSION}"
TARBALL="xdpyinfo-${VERSION}.tar.bz2"

DEPENDS=(
  libxi
  libxrender
  libxtst
  libxxf86misc
  libxxf86vm
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
b7cbab6cbcd12bf7ad65dbc12d86e104
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
  VERSION_STRING='xdpyinfo-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/xdpyinfo-%version%.tar.bz2'
  )
}
