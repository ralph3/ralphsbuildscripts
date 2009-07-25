#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.30"

DIR="iana-etc-${VERSION}"
TARBALL="iana-etc-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://www.sethwklein.net/projects/iana-etc/downloads/${TARBALL}
)

MD5SUMS=(
3ba3afb1d1b261383d247f46cb135ee8
)

build(){
  unpack_tarball $TARBALL
  cd $SRCDIR/$DIR || return 1
  make || return 1
  mkdir -p $TMPROOT/etc
  make install PREFIX=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.sethwklein.net/projects/iana-etc/downloads/'
  VERSION_STRING='iana-etc-%version%.tar.bz2'
  MIRRORS=(
    'http://www.sethwklein.net/projects/iana-etc/downloads/iana-etc-%version%.tar.bz2'
  )
}
