#!/bin/bash

DISABLE_MULTILIB=1

VERSION="256"

DIR="xterm-${VERSION}"
TARBALL="xterm-${VERSION}.tgz"

DEPENDS=(
  xorg-server
)

SRC1=(
ftp://invisible-island.net/xterm/${TARBALL}
)

MD5SUMS=(
6da5c166e1c633fc26917b66d6433f1f
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
  ADDRESS='ftp://invisible-island.net/xterm/'
  VERSION_STRING='xterm-%version%.tgz'
  MIRRORS=(
    'ftp://invisible-island.net/xterm/xterm-%version%.tgz'
  )
}
