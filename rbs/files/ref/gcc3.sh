#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.4.6"


DIR="gcc-${VERSION}"
TARBALL="gcc-${VERSION}.tar.bz2"

DEPENDS=(
  make
)

SRC1=(
http://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/$TARBALL
ftp://sources.redhat.com/pub/gcc/releases/gcc-${VERSION}/$TARBALL
)

MD5SUMS=(
4a21ac777d4b5617283ce488b808da7b
)

build(){
  local PATCHES CONF
  CONF=
  PATCHES="gcc-${VERSION}-linkonce-1.patch"
  case $(gcc -dumpmachine | cut -f1 -d'-') in
    i386|i486|i586|i686)
      CONF="--disable-multilib"
    ;;
    x86_64)
      case $RBS_SYSTYPE in
        64BIT)
          CONF="--disable-multilib"
        ;;
      esac
    ;;
  esac
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  do_patch $PATCHES || return 1
  mkdir -p $SRCDIR/gcc-build || return 1
  cd $SRCDIR/gcc-build || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ../$DIR/configure \
    --prefix=/usr/$LIBSDIR/gcc3 --libexecdir=/usr/$LIBSDIR/gcc3/$LIBSDIR \
    --enable-shared --enable-threads=posix --enable-__cxa_atexit --enable-c99 \
    --enable-long-long --enable-clocale=gnu --enable-languages=c,c++ \
    --disable-libstdcxx-pch $CONF || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  mkdir -vp $TMPROOT/usr/bin || return 1
  ln -vsfn /usr/$LIBSDIR/gcc3/bin/gcc $TMPROOT/usr/bin/gcc3 || return 1
  ln -vsfn /usr/$LIBSDIR/gcc3/bin/g++ $TMPROOT/usr/bin/g++3 || return 1
  cd ../ || return 1
  rm -rf gcc-build $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/gcc/gcc-%version%/'
  VERSION_STRING='gcc-%version%.tar.bz2'
  MINOR_VERSION="3"
  MIRRORS=(
    'http://ftp.gnu.org/gnu/gcc/gcc-%version%/gcc-%version%.tar.bz2'
  )
}
