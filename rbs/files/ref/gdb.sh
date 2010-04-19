#!/bin/bash

DISABLE_MULTILIB=1

VERSION="6.8"

DIR="gdb-${VERSION}"
TARBALL="gdb-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
  http://ftp.gnu.org/gnu/gdb/$TARBALL
)

MD5SUMS=(
c9da266b884fb8fa54df786dfaadbc7a
)

build(){
  local CONF
  CONF=
  [ "$SYSTYPE" == "MULTILIB" ] && [ "$BUILD" == "$BUILD32" ] && {
    CONF="--host=$BUILDTARGET"
  }
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure $CONF --prefix=/usr \
    --sysconfdir=/etc --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  #don't overwrite binutils' crap
  rm $TMPROOT/usr/$LIBSDIR/{libbfd.a,libiberty.a,libopcodes.a,*.la} || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/gdb/'
  VERSION_STRING='gdb-%version%.tar.bz2'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gdb/gdb-%version%.tar.bz2'
  )
}
