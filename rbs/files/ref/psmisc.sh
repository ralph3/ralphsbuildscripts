#!/bin/bash

DISABLE_MULTILIB=1

VERSION="22.11"

DIR="psmisc-${VERSION}"
TARBALL="psmisc-${VERSION}.tar.gz"

DEPENDS=(
  ncurses
)

SRC1=(
http://prdownloads.sourceforge.net/psmisc/${TARBALL}
)

MD5SUMS=(
b5d32aa285b75c59dee96d3ea26a4881
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --exec-prefix="" || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -p $TMPROOT/usr/bin || return 1
  mv $TMPROOT/bin/pstree* $TMPROOT/usr/bin || return 1
  ln -sfn killall $TMPROOT/bin/pidof || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=15273&package_id=15867'
  VERSION_STRING='psmisc-%version%.tar.gz'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/psmisc/psmisc-%version%.tar.gz'
  )
}