#!/bin/bash

VERSION="1.0.17"

DIR="alsa-oss-${VERSION}"
TARBALL="alsa-oss-${VERSION}.tar.bz2"

DEPENDS=(
  alsa-lib
)

SRC1=(
ftp://ftp.alsa-project.org/pub/oss-lib/${TARBALL}
)

MD5SUMS=(
1b1850c2fc91476a73d50f537cbd402f
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
  ADDRESS='ftp://ftp.alsa-project.org/pub/oss-lib/'
  VERSION_STRING='alsa-oss-%version%.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'ftp://ftp.alsa-project.org/pub/oss-lib/alsa-oss-%version%.tar.bz2'
  )
}
