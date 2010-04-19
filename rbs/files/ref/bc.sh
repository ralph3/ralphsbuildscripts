#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.06"

DIR="bc-${VERSION}"
TARBALL="bc-${VERSION}.tar.gz"

DEPENDS=(
  readline
)

SRC1=(
http://ftp.gnu.org/gnu/bc/${TARBALL}
)

MD5SUMS=(
d44b5dddebd8a7a7309aea6c36fda117
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch bc-1.06-flex_invocation-1.patch bc-1.06-readline-1.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
  --libdir=/usr/$LIBSDIR --with-readline || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/bc/'
  VERSION_STRING='bc-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/bc/bc-%version%.tar.gz'
  )
}
