#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.8.15"

DIR="irssi-${VERSION}"
TARBALL="irssi-${VERSION}.tar.bz2"

DEPENDS=(
  ncurses
)

SRC1=(
http://www.irssi.org/files/${TARBALL}
)

MD5SUMS=(
1dcb3f511b88df94b0c996f36668c7da
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
  ADDRESS='http://www.irssi.org/files/'
  VERSION_STRING='irssi-%version%.tar.bz2'
  VERSION_FILTERS='rc'
  MIRRORS=(
    'http://www.irssi.org/files/irssi-%version%.tar.bz2'
  )
}