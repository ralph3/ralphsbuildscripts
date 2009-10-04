#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.0.1"

DIR="lbxproxy-${VERSION}"
TARBALL="lbxproxy-${VERSION}.tar.bz2"

DEPENDS=(
  libice
  liblbxutil
  libxext
  xproxymanagementprotocol
)

SRC1=(
http://xorg.freedesktop.org/releases/individual/app/${TARBALL}
)

MD5SUMS=(
9d5045a5c76b1fe360221b967a5aa0e9
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
  VERSION_STRING='lbxproxy-%version%.tar.bz2'
  MIRRORS=(
    'http://xorg.freedesktop.org/releases/individual/app/lbxproxy-%version%.tar.bz2'
  )
}
