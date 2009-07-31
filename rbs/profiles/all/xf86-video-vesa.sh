#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.2.1"

DIR="xf86-video-vesa-${VERSION}"
TARBALL="xf86-video-vesa-${VERSION}.tar.bz2"

DEPENDS=(
  xorg-server
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/driver/${TARBALL}
)

MD5SUMS=(
61a1dc9a22991bd04d0ff98f800775c1
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var \
    --with-xorg-module-dir=/usr/$LIBSDIR/X11/modules || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xorg.freedesktop.org/releases/individual/driver/'
  VERSION_STRING='xf86-video-vesa-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/driver/xf86-video-vesa-%version%.tar.bz2'
  )
}
