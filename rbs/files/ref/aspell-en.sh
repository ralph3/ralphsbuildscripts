#!/bin/bash

DISABLE_MULTILIB=1

VERSION="6.0-0"

DIR="aspell6-en-${VERSION}"
TARBALL="aspell6-en-${VERSION}.tar.bz2"

DEPENDS=(
  aspell
)

SRC1=(
http://ftp.gnu.org/gnu/aspell/dict/en/${TARBALL}
)

MD5SUMS=(
16449e0a266e1ecc526b2f3cd39d4bc2
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  ./configure || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/aspell/dict/en/'
  VERSION_STRING='aspell6-en-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-%version%.tar.bz2'
  )
}
