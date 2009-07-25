#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.82"

DIR="syslinux-${VERSION}"
TARBALL="syslinux-${VERSION}.tar.bz2"

SRC1=(
http://www.kernel.org/pub/linux/utils/boot/syslinux/${TARBALL}
)

MD5SUMS=(
c9f4e73e385c86b3a8faf9b615a04836
)

build(){
  unpack_tarball $TARBALL || return 1
  mkdir -vp $TMPROOT/usr/src || return 1
  cp -va $SRCDIR/$DIR $TMPROOT/usr/src/ || return 1
  ln -vsfn $DIR $TMPROOT/usr/src/syslinux || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.kernel.org/pub/linux/utils/boot/syslinux/'
  VERSION_STRING='syslinux-%version%.tar.bz2'
  MIRRORS=(
    'http://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-%version%.tar.bz2'
  )
}
