#!/bin/bash

DISABLE_MULTILIB=1

VERSION="0.8.17"

DIR="leafpad-${VERSION}"
TARBALL="leafpad-${VERSION}.tar.gz"

DEPENDS=(
  gtk+
)

SRC1=(
http://nongnu.askapache.com/leafpad/${TARBALL}
)

MD5SUMS=(
d39acdf4d31de309d484511bdc9f5924
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
  ADDRESS="http://nongnu.askapache.com/leafpad/"
  VERSION_STRING="leafpad-%version%.tar.gz"
  MIRRORS=(
    "http://nongnu.askapache.com/leafpad/leafpad-%version%.tar.gz"
  )
}
