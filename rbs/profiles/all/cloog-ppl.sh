#!/bin/bash

VERSION="0.15.9"

DIR="cloog-ppl-${VERSION}"
TARBALL="cloog-ppl-${VERSION}.tar.gz"

DEPENDS=(
  ppl
)

SRC1=(
  ftp://gcc.gnu.org/pub/gcc/infrastructure/$TARBALL
)

MD5SUMS=(
806e001d1b1a6b130069ff6274900af5
)

RBS_Cross_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "/LD_LIBRARY_PATH=/d" configure || return 1
  LDFLAGS="-Wl,-rpath,/RBS-Cross-Tools/${LIBSDIR}" \
    ./configure --prefix=/RBS-Cross-Tools --enable-shared \
    --with-bits=gmp --with-gmp=/RBS-Cross-Tools \
    --with-ppl=/RBS-Cross-Tools || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i "/LD_LIBRARY_PATH=/d" configure || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" LDFLAGS="-lm -lstdc++" \
    ./configure --build=$BUILDHOST --host=$BUILDTARGET \
    --prefix=/RBS-Tools --libdir=/RBS-Tools/$LIBSDIR \
    --enable-shared --with-gmp=/RBS-Tools --with-ppl=/RBS-Tools \
    --with-bits=gmp || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC -isystem /usr/include $BUILD" \
  CXX="$CXX -isystem /usr/include $BUILD" LDFLAGS="-lm -lstdc++" ./configure \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR \
    --enable-shared --with-gmp --with-ppl || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://gcc.gnu.org/pub/gcc/infrastructure/'
  VERSION_STRING='cloog-ppl-%version%.tar.gz'
  MIRRORS=(
    'ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-ppl-%version%.tar.gz'
  )
}
