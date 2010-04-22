#!/bin/bash

VERSION="2.4.2"

DIR="bison-${VERSION}"
TARBALL="bison-${VERSION}.tar.gz"

DEPENDS=(
  m4
)

SRC1=(
http://ftp.gnu.org/gnu/bison/${TARBALL}
)

MD5SUMS=(
6fc502f135738e98fecf1e5c8de38d62
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  echo '#define YYENABLE_NLS 1' >> config.h || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/bison/'
  VERSION_STRING='bison-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/bison/bison-%version%.tar.gz'
  )
}