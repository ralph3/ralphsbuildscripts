#!/bin/bash

DISABLE_MULTILIB=1

## 1.11.1 may cause problems with xfce autogen.sh's

VERSION="1.11"

DIR="automake-${VERSION}"
TARBALL="automake-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/automake/${TARBALL}
)

MD5SUMS=(
4db4efe027e26b33930a7e151de19d0f
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
