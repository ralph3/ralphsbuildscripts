#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.4.3"

DIR="imlib2-${VERSION}"
TARBALL="imlib2-${VERSION}.tar.gz"

DEPENDS=(
  giflib
)

SRC1=(
http://prdownloads.sourceforge.net/enlightenment/${TARBALL}
)

MD5SUMS=(
17fb36411df0a274d15f88b56077cdd5
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure --prefix=/usr \
    --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS="http://sourceforge.net/projects/enlightenment/files/"
  VERSION_STRING="imlib2-%version%.tar.gz"
  MIRRORS=(
    "http://prdownloads.sourceforge.net/enlightenment/imlib2-%version%.tar.gz"
  )
}
