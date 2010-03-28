#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.3.2"

DIR="menu-cache-${VERSION}"
TARBALL="menu-cache-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/lxde/${TARBALL}
)

MD5SUMS=(
ac4a9ea77db68d3db3f9f53cc75af66a
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
  ADDRESS="http://sourceforge.net/projects/lxde/files/"
  VERSION_STRING="menu-cache-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lxde/menu-cache-%version%.tar.gz"
  )
}
