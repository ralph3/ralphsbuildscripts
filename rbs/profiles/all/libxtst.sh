#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.3"

DIR="libXtst-${VERSION}"
TARBALL="libXtst-${VERSION}.tar.bz2"

DEPENDS=(
  libxext
  recordproto
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/lib/${TARBALL}
)

MD5SUMS=(
090c1ad04e34982eada5cf3b1a0792fd
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
  VERSION_STRING='libXtst-%version%.tar.bz2'
  VERSION_FILTERS='99'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/lib/libXtst-%version%.tar.bz2'
  )
}
