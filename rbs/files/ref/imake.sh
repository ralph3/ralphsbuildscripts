#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.3"

ENABLE_MULTILIB=1

DIR="imake-${VERSION}"
TARBALL="imake-${VERSION}.tar.bz2"

DEPENDS=(
  xproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/util/${TARBALL}
)

MD5SUMS=(
ff553c4646edcc9e76b7308991ad421a
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/* || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/util/'
  VERSION_STRING='imake-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/util/imake-%version%.tar.bz2'
  )
}