#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.23"

DIR="tar-${VERSION}"
TARBALL="tar-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/tar/${TARBALL}
)

MD5SUMS=(
41e2ca4b924ec7860e51b43ad06cdb7e
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
