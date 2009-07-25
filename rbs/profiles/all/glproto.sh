#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.10"

DIR="glproto-${VERSION}"
TARBALL="glproto-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/proto/${TARBALL}
)

MD5SUMS=(
c9f8cebfba72bfab674bc0170551fb8d
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
  ADDRESS='http://xorg.freedesktop.org/releases/individual/proto/'
  VERSION_STRING='glproto-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/proto/glproto-%version%.tar.bz2'
  )
}
