#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.2.8"

DIR="procps-${VERSION}"
TARBALL="procps-${VERSION}.tar.gz"

DEPENDS=(
  ncurses
)

SRC1=(
http://procps.sourceforge.net/${TARBALL}
)

MD5SUMS=(
9532714b6846013ca9898984ba4cd7e0
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i -e "/^install  :=/s/--owner 0 --group 0//" \
    -e "/^ldconfig :=/s/= ldconfig/=/" Makefile || return 1
  make CC="$CC $BUILD" CXX="$CXX $BUILD" OPT="$CFLAGS -O2" \
    LIBDIR=/$LIBSDIR || return 1
  make install LIBDIR=/$LIBSDIR lib64=$LIBSDIR DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://procps.sourceforge.net/'
  VERSION_STRING='procps-%version%.tar.gz'
  MIRRORS=(
    'http://procps.sourceforge.net/procps-%version%.tar.gz'
  )
}
