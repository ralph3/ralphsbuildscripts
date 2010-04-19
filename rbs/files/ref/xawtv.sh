#!/bin/bash

DISABLE_MULTILIB=1

VERSION="3.95"

DIR="xawtv-${VERSION}"
TARBALL="xawtv-${VERSION}.tar.gz"

DEPENDS=(
  libfs
)

SRC1=(
http://dl.bytesex.org/releases/xawtv/${TARBALL}
)

MD5SUMS=(
ad25e03f7e128b318e392cb09f52207d
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  sed -i 's%# include <FSlib.h>%# include <X11/fonts/FSlib.h>%' console/fs.h || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make FS_LIBS="/usr/$LIBSDIR/libFS.a" || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://dl.bytesex.org/releases/xawtv/'
  VERSION_STRING='xawtv-%version%.tar.gz'
  MIRRORS=(
    'http://dl.bytesex.org/releases/xawtv/xawtv-%version%.tar.gz'
  )
}
