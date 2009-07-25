#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.1.5"

DIR="eject"
TARBALL="eject-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ca.geocities.com/jefftranter@rogers.com/${TARBALL}
)

MD5SUMS=(
b96a6d4263122f1711db12701d79f738
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr || return 1
  make || return 1
  make install prefix=$TMPROOT/usr || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ca.geocities.com/jefftranter@rogers.com/eject.html'
  VERSION_STRING='eject-%version%.tar.gz'
  MIRRORS=(
    'http://ca.geocities.com/jefftranter@rogers.com/eject-%version%.tar.gz'
  )
}
