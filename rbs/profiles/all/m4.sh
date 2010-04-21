#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.14"

DIR="m4-${VERSION}"
TARBALL="m4-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/m4/${TARBALL}
)

MD5SUMS=(
e6fb7d08d50d87e796069cff12a52a93
)

Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=$TCDIR || return 1
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
