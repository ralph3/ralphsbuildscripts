#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.2"

DIR="ed-${VERSION}"
TARBALL="ed-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/ed/${TARBALL}
)

MD5SUMS=(
ddd57463774cae9b50e70cd51221281b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch ed-0.2-mkstemp-1.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --exec-prefix="" || return 1
  make || return 1
  make install prefix=$TMPROOT/usr exec_prefix=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/ed/'
  VERSION_STRING='ed-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/ed/ed-%version%.tar.gz'
  )
}
