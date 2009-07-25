#!/bin/bash

DISABLE_MULTILIB=1

## stay at 1.5.x as 2.x causes problems. was noted in guile.
VERSION="1.5.26"

DIR="libtool-${VERSION}"
TARBALL="libtool-${VERSION}.tar.gz"

DEPENDS=(
  sed
)

SRC1=(
http://ftp.gnu.org/gnu/libtool/${TARBALL}
)

MD5SUMS=(
aa9c5107f3ec9ef4200eb6556f3b3c29
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  chown -Rv root:root $TMPROOT/usr/share/libtool/libltdl || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/libtool/'
  VERSION_STRING='libtool-%version%.tar.gz'
  MINOR_VERSION='1.5'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/libtool/libtool-%version%.tar.gz'
  )
}
