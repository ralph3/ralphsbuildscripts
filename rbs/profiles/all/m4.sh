#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.13"

DIR="m4-${VERSION}"
TARBALL="m4-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/m4/${TARBALL}
)

MD5SUMS=(
28f9ccd3ac4da45409251008b911d677
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
  make install prefix=$TMPROOT/usr || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/m4/'
  VERSION_STRING='m4-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/m4/m4-%version%.tar.bz2'
  )
}
