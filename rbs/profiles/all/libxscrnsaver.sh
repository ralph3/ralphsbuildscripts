#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.1.3"

DIR="libXScrnSaver-${VERSION}"
TARBALL="libXScrnSaver-${VERSION}.tar.bz2"

DEPENDS=(
  scrnsaverproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
93f84b6797f2f29cae1ce23b0355d00d
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/lib/'
  VERSION_STRING='libXScrnSaver-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-%version%.tar.bz2'
  )
}
