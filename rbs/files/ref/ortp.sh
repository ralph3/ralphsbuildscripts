#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.7.1"

DIR="ortp-${VERSION}"
TARBALL="ortp-${VERSION}.tar.gz"

DEPENDS=(
  make
)

SRC1=(
http://download.savannah.nongnu.org/releases/linphone/ortp/sources/${TARBALL}
)

MD5SUMS=(
e69ba3f5a2ac76e3b6117826d0c536b2
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://download.savannah.nongnu.org/releases/linphone/ortp/sources/'
  VERSION_STRING='ortp-%version%.tar.gz'
  #gaim 2beta2 needs 0.7 branch :/
  MINOR_VERSION='0.7'
  MIRRORS=(
    'http://download.savannah.nongnu.org/releases/linphone/ortp/sources/ortp-%version%.tar.gz'
  )
}
