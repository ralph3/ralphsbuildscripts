#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.11.23"

DIR="cvs-${VERSION}"
TARBALL="cvs-${VERSION}.tar.bz2"

DEPENDS=(
  nano
)

SRC1=(
http://ftp.gnu.org/non-gnu/cvs/source/stable/$VERSION/${TARBALL}
)

MD5SUMS=(
0213ea514e231559d6ff8f80a34117f0
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  
  do_patch cvs-1.11.23-glibc-2.10.1-1.patch || return 1
  
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/non-gnu/cvs/source/stable/%version%/'
  VERSION_STRING='cvs-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/non-gnu/cvs/source/stable/%version%/cvs-%version%.tar.bz2'
  )
}
