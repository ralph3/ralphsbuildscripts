#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.6"

DIR="xcb-proto-${VERSION}"
TARBALL="xcb-proto-${VERSION}.tar.bz2"

DEPENDS=(
  python
)

SRC1=(
http://xcb.freedesktop.org/dist/${TARBALL}
)

MD5SUMS=(
04313e1d914b44d0e457f6c494fc178b
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc --localstatedir=/var || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/usr/share/ || return 1
  mv $TMPROOT/usr/$LIBSDIR/pkgconfig $TMPROOT/usr/share/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://xcb.freedesktop.org/dist/'
  VERSION_STRING='xcb-proto-%version%.tar.bz2'
  MIRRORS=(
    'http://xcb.freedesktop.org/dist/xcb-proto-%version%.tar.bz2'
  )
}