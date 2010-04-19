#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.2"

DIR="xvidcore-${VERSION}"
TARBALL="xvidcore-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://downloads.xvid.org/downloads/$TARBALL
)

MD5SUMS=(
6a3473a12c8a1fa7bdc2b5cb829fab58
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR || return 1
  mv xvidcore $DIR || return 1
  cd $SRCDIR/$DIR/build/generic || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install prefix=$TMPROOT/usr libdir=$TMPROOT/usr/$LIBSDIR || return 1
  #chmod -v 644 $TMPROOT/usr/$LIBSDIR/libxvidcore.a || return 1
  #ln -v -sf libxvidcore.so.4.0 \
  #  $TMPROOT/usr/$LIBSDIR/libxvidcore.so.4 || return 1
  #ln -v -sf libxvidcore.so.4 \
  #  $TMPROOT/usr/$LIBSDIR/libxvidcore.so || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.xvid.org/'
  VERSION_STRING='Xvid %version% released'
  MIRRORS=(
    "http://downloads.xvid.org/downloads/xvidcore-%version%.tar.bz2"
  )
}
