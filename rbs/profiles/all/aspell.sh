#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.60.6"

DIR="aspell-${VERSION}"
TARBALL="aspell-${VERSION}.tar.gz"

DEPENDS=(
  gcc
  ncurses
)

SRC1=(
http://ftp.gnu.org/gnu/aspell/${TARBALL}
)

MD5SUMS=(
bc80f0198773d5c05086522be67334eb
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/pspell-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://ftp.gnu.org/gnu/aspell/"
  VERSION_STRING="aspell-%version%.tar.gz"
  MIRRORS=(
    "http://ftp.gnu.org/gnu/aspell/aspell-%version%.tar.gz"
  )
}
