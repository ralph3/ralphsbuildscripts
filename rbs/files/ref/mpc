#!/bin/bash

VERSION="0.8.1"

DIR="mpc-${VERSION}"
TARBALL="mpc-${VERSION}.tar.gz"

DEPENDS=(
  mpfr
)

SRC1=(
http://www.multiprecision.org/mpc/download/$TARBALL
)

MD5SUMS=(
5b34aa804d514cc295414a963aedb6bf
)

RBS_Cross_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  LDFLAGS="-Wl,-rpath,/RBS-Cross-Tools/$LIBSDIR" \
    ./configure --prefix=/RBS-Cross-Tools --disable-doc || return 1
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
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST --host=$BUILDTARGET \
    --prefix=/usr --libdir=/usr/$LIBSDIR --enable-shared || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.multiprecision.org/index.php?prog=mpc&page=download'
  VERSION_STRING='mpc-%version%.tar.gz'
  MIRRORS=(
    'http://www.multiprecision.org/mpc/download/mpc-%version%.tar.gz'
  )
}
