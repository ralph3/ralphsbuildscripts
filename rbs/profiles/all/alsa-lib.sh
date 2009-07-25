#!/bin/bash

VERSION="1.0.20"
SYS_VERSION="1.0.20-1"

DIR="alsa-lib-${VERSION}"
TARBALL="alsa-lib-${VERSION}.tar.bz2"

DEPENDS=(
  python
)

SRC1=(
http://ftp.silug.org/pub/alsa/lib/${TARBALL}
ftp://ftp.alsa-project.org/pub/lib/${TARBALL}
)

MD5SUMS=(
6e9080ba1faa5d3739d14dd76c62d8dc
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
  ADDRESS='http://ftp.silug.org/pub/alsa/lib/'
  VERSION_STRING='alsa-lib-%version%.tar.bz2'
  VERSION_FILTERS='[a-z] [A-Z]'
  MIRRORS=(
    'http://ftp.silug.org/pub/alsa/lib/alsa-lib-%version%.tar.bz2'
  )
}
