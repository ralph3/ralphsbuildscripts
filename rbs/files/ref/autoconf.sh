#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.65"

DIR="autoconf-${VERSION}"
TARBALL="autoconf-${VERSION}.tar.bz2"

DEPENDS=(
  m4
  perl
)

SRC1=(
http://ftp.gnu.org/gnu/autoconf/${TARBALL}
)

MD5SUMS=(
a6de1cc6434cd64038b0a0ae4e252b33
)

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
  ADDRESS='http://ftp.gnu.org/gnu/autoconf/'
  VERSION_STRING='autoconf-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/autoconf/autoconf-%version%.tar.bz2'
  )
}
