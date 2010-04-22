#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.10"

DIR="startup-notification-${VERSION}"
TARBALL="startup-notification-${VERSION}.tar.gz"

DEPENDS=(
  libsm
  libx11
  xcb-util
)

SRC1=(
http://www.freedesktop.org/software/startup-notification/releases/${TARBALL}
)

MD5SUMS=(
bca0ed1c74bc4e483ea2ed12a5717354
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
  ADDRESS='http://www.freedesktop.org/software/startup-notification/releases/'
  VERSION_STRING='startup-notification-%version%.tar.gz'
  MIRRORS=(
    'http://www.freedesktop.org/software/startup-notification/releases/startup-notification-%version%.tar.gz'
  )
}
