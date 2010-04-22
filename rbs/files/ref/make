#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.81"

DIR="make-${VERSION}"
TARBALL="make-${VERSION}.tar.bz2"

DEPENDS=(
  gcc
)

SRC1=(
http://ftp.gnu.org/gnu/make/${TARBALL}
)

MD5SUMS=(
354853e0b2da90c527e35aabb8d6f1e6
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/make/'
  VERSION_STRING='make-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/make/make-%version%.tar.bz2'
  )
}
