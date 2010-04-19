#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.16.17"

DIR="bin86-${VERSION}"
TARBALL="bin86-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://homepage.ntlworld.com/robert.debath/dev86/${TARBALL}
)

MD5SUMS=(
c9e8d72dd2e7457b52d0e3164fc199a1
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make CC="$CC $BUILD" -C as as86 || return 1
  make CC="$CC $BUILD" -C ld ld86 || return 1
  mkdir -vp $TMPROOT/usr/{bin,share/man/man1} || return 1
  install -v -m 755 as/as86 $TMPROOT/usr/bin/as86 || return 1
  install -v -m 755 ld/ld86 $TMPROOT/usr/bin/ld86 || return 1
  install -v -m 644 man/{as86,ld86}.1 \
    $TMPROOT/usr/share/man/man1 || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://homepage.ntlworld.com/robert.debath/dev86/'
  VERSION_STRING='bin86-%version%.tar.gz'
  MIRRORS=(
    'http://homepage.ntlworld.com/robert.debath/dev86/bin86-%version%.tar.gz'
  )
}
