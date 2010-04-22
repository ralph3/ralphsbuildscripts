#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.24"

DIR="man-pages-${VERSION}"
TARBALL="man-pages-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://www.kernel.org/pub/linux/docs/manpages/${TARBALL}
)

MD5SUMS=(
aca98183e51772ce81e17c78a46bea5d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make install prefix=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.kernel.org/pub/linux/docs/manpages/'
  VERSION_STRING='man-pages-%version%.tar.bz2'
  MIRRORS=(
    'http://www.kernel.org/pub/linux/docs/manpages/man-pages-%version%.tar.bz2'
  )
}