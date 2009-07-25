#!/bin/bash

DISABLE_MULTILIB=1

VERSION="1.6.0"

DIR="rdesktop-${VERSION}"
TARBALL="rdesktop-${VERSION}.tar.gz"

DEPENDS=(
  alsa-lib
)

SRC1=(
http://prdownloads.sourceforge.net/rdesktop/${TARBALL}
)

MD5SUMS=(
c6fcbed7f0ad7e60ac5fcb2d324d8b16
)

build(){
  unpack_tarball $TARBALL || return 1
  cd $SRCDIR/$DIR || return 1
  CC="$CC $BUILD" CXX="$CXX $BUILD" ./configure \
    --prefix=/usr --libdir=/usr/$LIBSDIR --sysconfdir=/etc || return 1
  make || return 1
  make install DESTDIR=$TMPROOT || return 1
  cd ../ || return 1
  rm -rf $DIR || return 1
}

version_check_info(){
  ADDRESS='http://sourceforge.net/project/showfiles.php?group_id=24366&package_id=16601'
  VERSION_STRING='rdesktop-%version%.tar.gz'
  VERSION_FILTERS="beta"
  MIRRORS=(
    'http://prdownloads.sourceforge.net/rdesktop/rdesktop-%version%.tar.gz'
  )
}
