#!/bin/bash

VERSION="6.1"

DIR="readline-${VERSION}"
TARBALL="readline-${VERSION}.tar.gz"

DEPENDS=(
  ncurses
)

SRC1=(
http://ftp.gnu.org/gnu/readline/${TARBALL}
)

MD5SUMS=(
fc2f7e714fe792db1ce6ddc4c9fb4ef3
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --build=$BUILDHOST \
    --host=$BUILDTARGET --prefix=/usr --libdir=/$LIBSDIR || return 1
  make SHLIB_XLDFLAGS=-lncurses || return 1
  make install DESTDIR=$TMPROOT || return 1
  chmod 755 $TMPROOT/$LIBSDIR/lib{readline,history}.so* || return 1
  mkdir -p $TMPROOT/usr/$LIBSDIR
  mv $TMPROOT/$LIBSDIR/lib{readline,history}.a $TMPROOT/usr/$LIBSDIR || return 1
  rm $TMPROOT/$LIBSDIR/lib{readline,history}.so || return 1
  ln -sf ../../$LIBSDIR/libreadline.so.$(echo ${VERSION} | cut -b1) \
    $TMPROOT/usr/$LIBSDIR/libreadline.so || return 1
  ln -sf ../../$LIBSDIR/libhistory.so.$(echo ${VERSION} | cut -b1) \
    $TMPROOT/usr/$LIBSDIR/libhistory.so || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://ftp.gnu.org/gnu/readline/'
  VERSION_STRING='readline-%version%.tar.gz'
  MIRRORS=(
    'http://ftp.gnu.org/gnu/readline/readline-%version%.tar.gz'
  )
}