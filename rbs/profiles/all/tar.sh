#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.22"

DIR="tar-${VERSION}"
TARBALL="tar-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/tar/${TARBALL}
)

MD5SUMS=(
07fa517027f426bb80f5f5ff91b63585
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  echo "gl_cv_func_wcwidth_works=yes" >> config.cache || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools \
    --cache-file=config.cache || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --bindir=/bin \
    --libexecdir=/usr/sbin || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/tar/'
  VERSION_STRING='tar-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/tar/tar-%version%.tar.bz2'
  )
}
