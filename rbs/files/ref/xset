#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.0"

DIR="xset-${VERSION}"
TARBALL="xset-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
eeb0d02f69c76bd40470dede99b4bd49
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
  VERSION_STRING='xset-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/xset-%version%.tar.bz2'
  )
}
