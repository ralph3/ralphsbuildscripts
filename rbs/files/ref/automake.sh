#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.11.1"

DIR="automake-${VERSION}"
TARBALL="automake-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/automake/${TARBALL}
)

MD5SUMS=(
c2972c4d9b3e29c03d5f2af86249876f
)

build(){
  unpack_tarball $TARBALL
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/automake/'
  VERSION_STRING='automake-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/automake/automake-%version%.tar.bz2'
  )
}
