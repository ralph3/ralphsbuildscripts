#!/bin/bash

VERSION="1.2.4"
SYS_VERSION="1.2.4-3"

DIR="zlib-${VERSION}"
TARBALL="zlib-${VERSION}.tar.bz2"

DEPENDS=(
  glibc
)

SRC1=(
http://prdownloads.sourceforge.net/libpng/$TARBALL
http://www.zlib.net/${TARBALL}
)

MD5SUMS=(
763c6a0b4ad1cdf5549e3ab3f140f4cb
)

RBS_Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CFLAGS="$CFLAGS -fPIC" \
    ./configure --prefix=/RBS-Tools \
    --libdir=/RBS-Tools/$LIBSDIR || return 1
  make || return 1
  make install || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" CFLAGS="$CFLAGS -fPIC" \
    ./configure --prefix=/usr --libdir=/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/usr/$LIBSDIR || return 1
  mv $TMPROOT/$LIBSDIR/{libz.a,pkgconfig} \
    $TMPROOT/usr/$LIBSDIR/ || return 1
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
