#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.2.13"

DIR="SDL-${VERSION}"
TARBALL="SDL-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://ftp.br.freebsd.org/distfiles/${TARBALL}
http://www.libsdl.org/release/${TARBALL}
)

MD5SUMS=(
c6660feea2a6834de10bc71b2f8e4d88
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --disable-audio || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/sdl-config || return 1
  install -v -m755 -d $TMPROOT/usr/share/doc/SDL-${VERSION}/html || return 1
  install -v -m644 docs/html/*.html \
    $TMPROOT/usr/share/doc/SDL-${VERSION}/html || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://www.libsdl.org/release/'
  VERSION_STRING='SDL-%version%.tar.gz'
  VERSION_FILTERS='[a-z]'
  MIRRORS=(
    'http://www.libsdl.org/release/SDL-%version%.tar.gz'
  )
}
