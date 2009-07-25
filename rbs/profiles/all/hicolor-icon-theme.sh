#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.5"

DIR="hicolor-icon-theme-${VERSION}"
TARBALL="hicolor-icon-theme-${VERSION}.tar.gz"

DEPENDS=(
  shared-mime-info
  desktop-file-utils
)

SRC1=(
http://freedesktop.org/software/icon-theme/releases/${TARBALL}
)

MD5SUMS=(
947c7f6eb68fd95c7b86e87f853ceaa0
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
  ADDRESS='http://freedesktop.org/software/icon-theme/releases/'
  VERSION_STRING='hicolor-icon-theme-%version%.tar.gz'
  MIRRORS=(
    'http://freedesktop.org/software/icon-theme/releases/hicolor-icon-theme-%version%.tar.gz'
  )
}
