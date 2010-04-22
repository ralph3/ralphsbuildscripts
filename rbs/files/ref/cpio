#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.9"

DIR="cpio-${VERSION}"
TARBALL="cpio-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  $(gnu_mirrors cpio)
)

MD5SUMS=(
e387abfdae3a0b9a8a5f762db653a96d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e "s/invalid_arg/argmatch_invalid/" src/mt.c || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure MT_PROG=mt --prefix=/usr \
    --libdir=/usr/$LIBSDIR --bindir=/bin --libexecdir=/tmp \
    --with-rmt=/usr/sbin/rmt || return 1
  make || return 1
  echo "#define HAVE_SETLOCALE 1" >> config.h
  echo "#define HAVE_LSTAT 1" >> config.h
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/cpio/'
  VERSION_STRING='cpio-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/cpio/cpio-%version%.tar.bz2'
  )
}
