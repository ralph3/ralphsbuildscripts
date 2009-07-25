#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.3.8"

DIR="apr-util-${VERSION}"
TARBALL="apr-util-${VERSION}.tar.bz2"

DEPENDS=(
  apr
  expat
  sed
)

SRC1=(
http://apache.cs.utah.edu/apr/${TARBALL}
)

MD5SUMS=(
34a0e815cdc2b79bf561468b84ff1aa3
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --with-apr=/usr || return 1
  sed -i "s%/usr/lib/%/usr/${LIBSDIR}/%g" $(grep -rl '/usr/lib/' *) || return 1
  make || return 1
  make DESTDIR=$TMPROOT install || return 1
  set_multiarch $TMPROOT/usr/bin/apu-1-config || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://apr.apache.org/download.cgi'
  VERSION_STRING='apr-util-%version%.tar.bz2'
  MIRRORS=(
    'http://apache.cs.utah.edu/apr/apr-util-%version%.tar.bz2'
  )
}
