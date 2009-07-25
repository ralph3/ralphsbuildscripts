#!/bin/bash

VERSION="1.2.3"
SYS_VERSION="1.2.3-1"

DIR="zlib-${VERSION}"
TARBALL="zlib-${VERSION}.tar.bz2"

DEPENDS=(
  glibc
)

SRC1=(
http://www.zlib.net/${TARBALL}
)

MD5SUMS=(
dee233bf288ee795ac96a98cc2e369b6
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/RBS-Tools --shared \
    --libdir=/RBS-Tools/$LIBSDIR || return 1
  make AR="$AR rc" || return 1
  make install || return 1
  make clean
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/RBS-Tools \
    --libdir=/RBS-Tools/$LIBSDIR || return 1
  make AR="$AR rc" || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch zlib-1.2.3-fPIC-1.patch || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr --shared \
    --libdir=/$LIBSDIR || return 1
  LD_LIBRARY_PATH=/$LIBSDIR:/usr/$LIBSDIR:/RBS-Tools/$LIBSDIR make AR="${AR} rc" || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/$LIBSDIR || return 1
  rm $TMPROOT/$LIBSDIR/libz.so || return 1
  ln -sf ../../$LIBSDIR/libz.so.${VERSION} $TMPROOT/usr/$LIBSDIR/libz.so
  make clean || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  LD_LIBRARY_PATH=/$LIBSDIR:/usr/$LIBSDIR:/RBS-Tools/$LIBSDIR make AR="${AR} rc" || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  mv $TMPROOT/$LIBSDIR/libz.a $TMPROOT/usr/$LIBSDIR/ || return 1
  chmod 644 $TMPROOT/usr/$LIBSDIR/libz.a || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.zlib.net/'
  VERSION_STRING='zlib-%version%.tar.bz2'
  MIRRORS=(
    'http://www.zlib.net/zlib-%version%.tar.bz2'
  )
}
