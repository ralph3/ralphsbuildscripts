#!/bin/bash

DISABLE_MULTILIB=1

VERSION="2.11"

DIR="dosfstools-${VERSION}"
TARBALL="dosfstools-${VERSION}.src.tar.gz"

DEPENDS=(
  make
)

SRC1=(
ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/${TARBALL}
)

MD5SUMS=(
407d405ade410f7597d364ab5dc8c9f6
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  make CC="$CC $BUILD" || return 1
  mkdir -p $TMPROOT/{sbin,usr/share/man/man8} || return 1
  make install SBINDIR=$TMPROOT/sbin \
    MANDIR=$TMPROOT/usr/share/man/man8 || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/'
  VERSION_STRING='dosfstools-%version%.src.tar.gz'
  MIRRORS=(
    'ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/dosfstools-%version%.src.tar.gz'
  )
}