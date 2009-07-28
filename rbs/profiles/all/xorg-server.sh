#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.6.2"

DIR="xorg-server-${VERSION}"
TARBALL="xorg-server-${VERSION}.tar.bz2"

DEPENDS=(
  glproto
  libpciaccess
  mesa
  pixman
  xf86bigfontproto
  xf86dgaproto
  xf86driproto
  xineramaproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/xserver/${TARBALL}
)

MD5SUMS=(
37641d0899df8a9c4a6284586d932b8d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var \
    --with-module-dir=/usr/$LIBSDIR/X11/modules || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/xserver/'
  VERSION_STRING='xorg-server-%version%.tar.bz2'
  VERSION_FILTERS='\.99 \.90'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/xserver/xorg-server-%version%.tar.bz2'
  )
}
