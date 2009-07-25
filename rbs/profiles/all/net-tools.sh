#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.60"

DIR="net-tools-${VERSION}"
TARBALL="net-tools-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://www.tazenda.demon.co.uk/phil/net-tools/${TARBALL}
)

MD5SUMS=(
888774accab40217dde927e21979c165
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch net-tools-1.60-fixes-2.patch || return 1
  yes "" | make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  make BASEDIR=$TMPROOT update || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.tazenda.demon.co.uk/phil/net-tools/'
  VERSION_STRING='net-tools-%version%.tar.bz2'
  MIRRORS=(
    'http://www.tazenda.demon.co.uk/phil/net-tools/net-tools-%version%.tar.bz2'
  )
}
