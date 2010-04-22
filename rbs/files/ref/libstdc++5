#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.3.6"
SYS_VERSION="3.3.6-1"

DIR="gcc-${VERSION}"

DEPENDS=(
  make
)

SRC1=(
ftp://sources.redhat.com/pub/gcc/releases/gcc-${VERSION}/gcc-core-${VERSION}.tar.bz2
)

SRC2=(
ftp://sources.redhat.com/pub/gcc/releases/gcc-${VERSION}/gcc-g++-${VERSION}.tar.bz2
)

MD5SUMS=(
18c52e6fb8966b7700665dca289d077f
6b3d00b8d079805be1b895f7f6ce47a0
)

build(){
  unset CFLAGS CXXFLAGS
  unpack_tarball gcc-core-${VERSION}.tar.bz2 || return 1
  unpack_tarball gcc-g++-${VERSION}.tar.bz2 || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --libexecdir=/usr/$LIBSDIR --enable-shared \
    --enable-threads=posix --enable-__cxa_atexit \
    --enable-clocale=gnu --enable-languages=c++ || return 1
  make all-target-libstdc++-v3 || return 1
  make install-target-libstdc++-v3 DESTDIR=$TMPROOT || return 1
  rm -rf $TMPROOT/usr/{include,$LIBSDIR/{*.*a,*.so},share}
  if [ -d "$TMPROOT/usr/lib" ]; then
    rm -rf $TMPROOT/usr/lib/{*.*a,*.so}
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://sources.redhat.com/pub/gcc/releases/gcc-%version%/'
  VERSION_STRING='gcc-core-%version%.tar.bz2'
  MINOR_VERSION='3.3'
  MIRRORS=(
    'ftp://sources.redhat.com/pub/gcc/releases/gcc-%version%/gcc-core-%version%.tar.bz2'
    'ftp://sources.redhat.com/pub/gcc/releases/gcc-%version%/gcc-g++-%version%.tar.bz2'
  )
}
