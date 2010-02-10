#!/bin/bash

DISABLE_MULTILIB=1

VERSION="7.20.0"

TARBALL="curl-${VERSION}.tar.bz2"
DIR="curl-${VERSION}"

DEPENDS=(
  openssl
)

SRC1=(
http://mirrorspace.org/curl/$TARBALL
http://curl.haxx.se/download/${TARBALL}
)

MD5SUMS=(
3dda78c4a808d9a779dc3a2ae81b47d8
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/curl-config || return 1
  find docs -name "Makefile*" -o -name "*.1" -o -name "*.3" | xargs rm || return 1
  install -v -d -m755 $TMPROOT/usr/share/doc/curl-${VERSION} || return 1
  cp -v -R docs/* $TMPROOT/usr/share/doc/curl-${VERSION} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://curl.haxx.se/download/'
  VERSION_STRING='curl-%version%.tar.bz2'
  MIRRORS=(
    "http://curl.haxx.se/download/curl-%version%.tar.bz2"
  )
}
