#!/bin/bash

DISABLE_MULTILIB=1

VERSION="4.1.6"

DIR="giflib-${VERSION}"
TARBALL="giflib-${VERSION}.tar.bz2"

DEPENDS=(
  libx11
)

SRC1=(
  http://prdownloads.sourceforge.net/giflib/$TARBALL
)

MD5SUMS=(
7125644155ae6ad33dbc9fc15a14735f
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
  ADDRESS='http://sourceforge.net/projects/giflib/files/'
  VERSION_STRING='giflib-%version%.tar.bz2'
  VERSION_FILTERS='/'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/libungif/giflib-%version%.tar.bz2"
  )
}
