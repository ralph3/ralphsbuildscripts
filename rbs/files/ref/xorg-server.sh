#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.8.0"

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
7cec3a11890bb53f4a07854319360348
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var \
    --with-module-dir=/usr/$LIBSDIR/X11/modules \
    --with-fontdir=/usr/share/fonts/X11 || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cp -va hw/xfree86/parser/xf86{Parser,Optrec}.h \
    $TMPROOT/usr/include/xorg/ || return 1
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