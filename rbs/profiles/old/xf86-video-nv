#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.1.12"

DIR="xf86-video-nv-${VERSION}"
TARBALL="xf86-video-nv-${VERSION}.tar.bz2"

DEPENDS=(
  xorg-server
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/driver/${TARBALL}
)

MD5SUMS=(
42f12a36d7afc26c817e8e8f5c8b7274
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
  VERSION_STRING='xf86-video-nv-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/driver/xf86-video-nv-%version%.tar.bz2'
  )
}
