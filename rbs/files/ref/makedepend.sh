#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.2"

DIR="makedepend-${VERSION}"
TARBALL="makedepend-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/util/${TARBALL}
)

MD5SUMS=(
62e58330fe8d1e3e28c7a45779833a48
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/util/'
  VERSION_STRING='makedepend-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/util/makedepend-%version%.tar.bz2'
  )
}
