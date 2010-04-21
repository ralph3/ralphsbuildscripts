#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.5.4"

DIR="grep-${VERSION}"
TARBALL="grep-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/grep/${TARBALL}
)

MD5SUMS=(
5650ee2ae6ea4b39e9459d7d0585b315
)

Tools_Build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=$TCDIR --bindir=$TCDIR/bin \
    --disable-perl-regexp || return 1
  make || return 1
  make install || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --bindir=/bin \
    --disable-perl-regexp || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/grep/'
  VERSION_STRING='grep-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/grep/grep-%version%.tar.bz2'
  )
}
