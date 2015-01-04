#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10"
SYS_VERSION="0.10-1"

DIR="lrmi-$VERSION"
TARBALL="lrmi-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/lrmi/${TARBALL}
)

MD5SUMS=(
fc1d9495e8f4563fca471bb65f34a5da
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" || return 1
  mkdir -vp $TMPROOT/usr/{sbin,$LIBSDIR} || return 1
  cp -va vbetest $TMPROOT/usr/sbin/ || return 1
  cp -va *.so* *.a $TMPROOT/usr/$LIBSDIR/ || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://prdownloads.sourceforge.net/lrmi/'
  VERSION_STRING='lrmi-%version%.tar.gz'
  MIRRORS=(
    "http://prdownloads.sourceforge.net/lrmi/lrmi-%version%.tar.gz"
  )
}
