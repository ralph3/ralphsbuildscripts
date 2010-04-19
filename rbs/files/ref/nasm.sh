#!/bin/bash

VERSION="2.07"

DIR="nasm-${VERSION}"
TARBALL="nasm-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/nasm/${TARBALL}
)

MD5SUMS=(
d8934231e81874c29374ddef1fbdb1ed
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr || return 1
  make || return 1
  mkdir -p $TMPROOT/usr/{bin,man/man1}
  make install prefix=$TMPROOT/usr || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/projects/nasm/files/'
  VERSION_STRING='nasm-%version%.tar.bz2'
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/nasm/nasm-%version%.tar.bz2'
  )
}
