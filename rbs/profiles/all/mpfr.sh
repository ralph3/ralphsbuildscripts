#!/bin/bash

VERSION="2.4.1"

DIR="mpfr-${VERSION}"
TARBALL="mpfr-${VERSION}.tar.bz2"

DEPENDS=(
  gmp
)

SRC1=(
  ftp://sources.redhat.com/pub/gcc/infrastructure/$TARBALL
)

MD5SUMS=(
c5ee0a8ce82ad55fe29ac57edd35d09e
)

RBS_Cross_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  LDFLAGS="-Wl,-rpath,/RBS-Cross-Tools/${LIBSDIR}" \
    ./configure --prefix=/RBS-Cross-Tools --enable-shared \
    --with-gmp=/RBS-Cross-Tools || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/RBS-Tools --libdir=/RBS-Tools/$LIBSDIR \
    --enable-shared || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --sysconfdir=/etc --libdir=/usr/$LIBSDIR \
    --enable-shared || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://sources.redhat.com/pub/gcc/infrastructure/'
  VERSION_STRING='mpfr-%version%.tar.bz2'
  MIRRORS=(
    'ftp://sources.redhat.com/pub/gcc/infrastructure/mpfr-%version%.tar.bz2'
  )
}
