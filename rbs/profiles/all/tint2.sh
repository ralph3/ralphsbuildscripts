#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.9"

DIR="tint2-${VERSION}"
TARBALL="tint2-${VERSION}.tar.gz"

DEPENDS=(
  xorg-server
  imlib2
)

SRC1=(
http://tint2.googlecode.com/files/${TARBALL}
)

MD5SUMS=(
411de6ccb8b82089852d8c854b12ddb9
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://code.google.com/p/tint2/downloads/list"
  VERSION_STRING="tint2-%version%.tar.gz"
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    "http://tint2.googlecode.com/files/tint2-%version%.tar.gz"
  )
}
