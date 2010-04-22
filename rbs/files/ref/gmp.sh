#!/bin/bash

VERSION="5.0.1"

DIR="gmp-${VERSION}"
TARBALL="gmp-${VERSION}.tar.gz"

DEPENDS=(
  glibc
)

SRC1=(
http://ftp.gnu.org/gnu/gmp/${TARBALL}
)

MD5SUMS=(
5ec19db53ced047b8d0d52373f6c245d
)

RBS_Cross_Tools_Build(){
  unset CFLAGS CXXFLAGS
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CPPFLAGS=-fexceptions ./configure --prefix=/RBS-Cross-Tools --enable-cxx || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

RBS_Tools_Build(){
  unset CFLAGS CXXFLAGS
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CPPFLAGS=-fexceptions ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools --libdir=/RBS-Tools/$LIBSDIR \
    --enable-cxx --enable-mpbsd || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unset CFLAGS CXXFLAGS
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CPPFLAGS=-fexceptions \
    ./configure gmp_cv_asm_underscore=no gmp_cv_asm_w32=".long" \
    --build=$BUILDHOST --host=$BUILDTARGET --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --enable-cxx \
    --enable-mpbsd || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  if [ "$SYSTYPE" == "MULTILIB" ]; then
    mv -v $TMPROOT/usr/include/gmp{,-${USE_ARCH}}.h || return 1
cat > $TMPROOT/usr/include/gmp.h << "EOF" || return 1
#ifndef __STUB__GMP_H__
#define __STUB__GMP_H__

#if defined(__x86_64__) || \
    defined(__sparc64__) || \
    defined(__arch64__) || \
    defined(__powerpc64__) || \
    defined (__s390x__)
# include "gmp-64.h"
#else
# include "gmp-32.h"
#endif

#endif
EOF
  fi
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/gmp/'
  VERSION_STRING='gmp-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gmp/gmp-%version%.tar.gz'
  )
}