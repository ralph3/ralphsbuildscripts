#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.3.6"

DIR="xcb-util-${VERSION}"
TARBALL="xcb-util-${VERSION}.tar.bz2"

DEPENDS=(
  gperf
  libxcb
)

SRC1=(
http://xcb.freedesktop.org/dist/${TARBALL}
)

MD5SUMS=(
dd8968b8ee613cb027a8ef1fcbdc8fc9
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
  ADDRESS='http://xcb.freedesktop.org/dist/'
  VERSION_STRING='xcb-util-%version%.tar.bz2'
  MIRRORS=(
    'http://xcb.freedesktop.org/dist/xcb-util-%version%.tar.bz2'
  )
}
