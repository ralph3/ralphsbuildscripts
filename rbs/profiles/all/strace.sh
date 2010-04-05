#!/bin/bash

VERSION="4.5.19"

ENABLE_MULTILIB=1

DIR="strace-${VERSION}"
TARBALL="strace-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://prdownloads.sourceforge.net/strace/${TARBALL}
)

MD5SUMS=(
2415e435d61e40315a298c80aced0cda
)

build(){
  mkdir -p $SRCDIR || return 1
  cd $SRCDIR || return 1
  rm -rf $DIR || return 1
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  for x in configure configure.ac; do
    sed -i 's%linux/socket.h%sys/socket.h%g' $x || return 1
  done
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  set_multiarch $TMPROOT/usr/bin/strace || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=2861&package_id=2819'
  VERSION_STRING='strace-%version%.tar.bz2'
  MIRRORS=(
    'http://prdownloads.sourceforge.net/strace/strace-%version%.tar.bz2'
  )
}
