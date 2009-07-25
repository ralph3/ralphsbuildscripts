#!/bin/bash

VERSION="1.1.1"
SYS_VERSION="1.1.1-2"

DIR="libXdamage-${VERSION}"
TARBALL="libXdamage-${VERSION}.tar.bz2"

DEPENDS=(
  damageproto
  libxt
  libxfixes
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
ac0ce6b0063a9858c8f24ddb4c60487d
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
  VERSION_STRING='libXdamage-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXdamage-%version%.tar.bz2'
  )
}
