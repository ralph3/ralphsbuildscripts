#!/bin/bash

DISABLE_MULTILIB=1

VERSION="418"

DIR="less-${VERSION}"
TARBALL="less-${VERSION}.tar.gz"

DEPENDS=(
  ncurses
)

SRC1=(
http://ftp.gnu.org/gnu/less/${TARBALL}
)

MD5SUMS=(
b5864d76c54ddf4627fd57ab333c88b4
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --bindir=/bin || return 1
  make || return 1
  make install prefix=$TMPROOT/usr bindir=$TMPROOT/bin || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/less/'
  VERSION_STRING='less-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/less/less-%version%.tar.gz'
  )
}
