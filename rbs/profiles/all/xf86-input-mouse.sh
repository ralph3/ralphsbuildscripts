#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.99.1"

DIR="xf86-input-mouse-${VERSION}"
TARBALL="xf86-input-mouse-${VERSION}.tar.bz2"

DEPENDS=(
  xorg-server
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/driver/${TARBALL}
)

MD5SUMS=(
092c125d0d45a98f8450aefaffd5c10f
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
  VERSION_STRING='xf86-input-mouse-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/driver/xf86-input-mouse-%version%.tar.bz2'
  )
}
