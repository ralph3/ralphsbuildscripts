#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.8.6"

DIR="guile-${VERSION}"
TARBALL="guile-${VERSION}.tar.gz"

DEPENDS=(
  gmp
  libtool
  readline
)

SRC1=(
http://ftp.gnu.org/gnu/guile/${TARBALL}
)

MD5SUMS=(
9e23d3dbea0e89bab8a9acc6880150de
)

build(){
  unpack_tarball $TARBALL
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/guile-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/guile/'
  VERSION_STRING='guile-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/guile/guile-%version%.tar.gz'
  )
}
